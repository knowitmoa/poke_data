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
),

change_types_drop_flavors as (
    select
    cast(berryName as TEXT) as berryName,
    cast(id as integer) as id,
    firmness,
    cast(growth_time as integer) as growth_time,
    itemname,
    cast(max_harvest as integer) as max_harvest,
    cast(natural_gift_power as integer) as natural_gift_power,
    natural_gift_type,
    cast(size as integer) as size,
    cast(smoothness as integer) as smoothness,
    cast(soil_dryness as integer) as soil_dryness
    from cleaned_data



)

select
    *
from change_types_drop_flavors


