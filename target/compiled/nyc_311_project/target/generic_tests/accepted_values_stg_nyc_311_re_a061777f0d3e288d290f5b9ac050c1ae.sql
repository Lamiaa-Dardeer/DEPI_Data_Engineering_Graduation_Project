
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
    group by status

)

select *
from all_values
where value_field not in (
    'Closed','Open','Pending','Assigned','In Progress'
)


