import duckdb
import matplotlib.pyplot as plt





def plot_large_berries():
    conn = duckdb.connect('poke_data.db') 
    
    largeBerries = conn.execute("SELECT * FROM dim_larger_avg_berries").fetchdf()

    plt.figure()
    plt.bar(largeBerries['berryName'], largeBerries['size'])

    plt.xticks(rotation=70)


    plt.xlabel('Berry names')
    plt.ylabel('Sizes')
    plt.title('Berries larger than the average')
    plt.savefig('bar_plot_large_berries.png')
    conn.close() 

def plot_small_berries():
    conn = duckdb.connect('poke_data.db') 
    
    smallBerries = conn.execute("SELECT * FROM dim_smaller_avg_berries").fetchdf()

    plt.figure()

    plt.bar(smallBerries['berryName'], smallBerries['size'])

    plt.xticks(rotation=70)


    plt.xlabel('Berry names')
    plt.ylabel('Sizes')
    plt.title('Berries smaller than the average')
    plt.savefig('bar_plot_small_berries.png')
    conn.close()


def plot_all_berries():
    conn = duckdb.connect('poke_data.db') 
    
    allBerries = conn.execute("SELECT berryName, size FROM stg_berries").fetchdf()

    plt.figure()

    plt.bar(allBerries['berryName'], allBerries['size'])

    plt.xticks(rotation=70)

    plt.xticks(fontsize=8)
    plt.xlabel('Berry names')
    plt.ylabel('Sizes')
    plt.title('Berry sizes')
    plt.savefig('bar_all_berries.png')
    conn.close() 

def print_table():
    conn = duckdb.connect('poke_data.db')
    query = 'SELECT * FROM stg_berries'
    df = conn.execute(query).fetchdf()
    print(df.head(65))


    
plot_all_berries()
plot_large_berries()
plot_small_berries()

print_table()





