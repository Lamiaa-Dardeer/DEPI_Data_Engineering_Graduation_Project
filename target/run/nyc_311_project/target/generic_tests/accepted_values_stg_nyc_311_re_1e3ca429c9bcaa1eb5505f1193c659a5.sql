
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        complaint_status as value_field,
        count(*) as n_records

    from `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
    group by complaint_status

)

select *
from all_values
where value_field not in (
    'Closed','Open','Pending','Assigned','In Progress','Started','Unspecified'
)



  
  
      
    ) dbt_internal_test