
    
    

with all_values as (

    select
        priority_level as value_field,
        count(*) as n_records

    from `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
    group by priority_level

)

select *
from all_values
where value_field not in (
    'High','Medium','Low'
)


