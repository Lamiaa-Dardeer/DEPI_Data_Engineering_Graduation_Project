
    
    

with dbt_test__target as (

  select complaint_type as unique_field
  from `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
  where complaint_type is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


