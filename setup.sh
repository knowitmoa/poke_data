#!/bin/bash

# Define the Python file to run
CURRENT_DIR=$(pwd)
PYTHON_FILE="$CURRENT_DIR/data/fetch_data.py" # Replace with your actual Python file name
DATA_BASE_TOOL="$CURRENT_DIR/poke_data_dbt"
VENV_DIR=".venv"

echo $PYTHON_FILE
# Check if the virtual environment directory exists
if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment already exists."
else
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"

    echo "Virtual environment created."
fi
echo "Activating the virtual environment..."
source "$CURRENT_DIR/.venv/bin/activate"




# Install packages from requirements.txt
if [[ -f "$CURRENT_DIR/requirements.txt" ]]; then
    echo "Installing packages from requirements.txt..."
    pip install -r $CURRENT_DIR/requirements.txt
else
    echo "No requirements.txt found."
fi

# Run the specified Python file
if [ -f "$PYTHON_FILE" ]; then
    echo "Running the Python file: $PYTHON_FILE..."
    python3 $PYTHON_FILE
else
    echo "Python file $PYTHON_FILE not found!"
    exit 1
fi

if [ -d "$DATA_BASE_TOOL" ]; then
    cd "$DATA_BASE_TOOL" || exit 1  # Change to the directory; exit if it fails
    echo "Running dbt run in the directory: $DATA_BASE_TOOL..."
    dbt run  # Execute the dbt command
else
    echo "Directory $DATA_BASE_TOOL not found!"
    exit 1
fi

# # Deactivate the virtual environment
echo "Deactivating the virtual environment..."
deactivate

echo "Script completed successfully."



CRON_JOB="* 1 * * * /bin/bash $CURRENT_DIR/setup.sh >> $CURRENT_DIR/logfile.log 2>&1"

# Check if the cron job already exists
if ! crontab -l | grep -qF "$CRON_JOB"; then
    # Add the cron job
    (crontab -l; echo "$CRON_JOB") | crontab -
    echo "Cron job added: $CRON_JOB"
else
    echo "Cron job already exists: $CRON_JOB"
fi
