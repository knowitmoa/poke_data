with stg_data as (
    select * from {{ ref('stg_berries') }}
),

smaller_avg_berries as (
    SELECT berryName, size 
    FROM stg_data
    WHERE size < (SELECT avg(size) FROM stg_data)
)

SELECT * FROM smaller_avg_berries