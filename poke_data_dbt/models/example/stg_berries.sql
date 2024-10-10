with src_data as (
    select * from {{ ref('src_berries') }}
),

cleaned_data as (
    select
        id ,
        name as berryName,  
        firmness::json->>'name' as firmness,
        flavors,
        growth_time,
        item::json->>'name' as itemname,
        max_harvest,
        natural_gift_power,
        natural_gift_type::json->>'name' as natural_gift_type,
        size,  
        smoothness,
        soil_dryness
    from src_data
)

select
    *
from cleaned_data


