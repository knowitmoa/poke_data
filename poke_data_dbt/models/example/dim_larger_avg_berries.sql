with stg_data as (
    select * from {{ ref('stg_berries') }}
),

larger_avg_berries as (
    SELECT berryName, size 
    FROM stg_data
    WHERE size > (SELECT avg(size) FROM stg_data)
)

SELECT * FROM larger_avg_berries