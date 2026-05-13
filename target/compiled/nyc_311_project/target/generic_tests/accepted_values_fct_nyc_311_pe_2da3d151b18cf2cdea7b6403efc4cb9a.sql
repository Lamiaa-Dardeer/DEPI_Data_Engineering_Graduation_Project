
    
    

with all_values as (

    select
        creation_month as value_field,
        count(*) as n_records

    from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
    group by creation_month

)

select *
from all_values
where value_field not in (
    'January','February','March','April','May','June','July','August','September','October','November','December'
)


