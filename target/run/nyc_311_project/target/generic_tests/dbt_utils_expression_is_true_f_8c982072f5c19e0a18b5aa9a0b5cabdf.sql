
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`

where not(ticket_age_days >= 0)


  
  
      
    ) dbt_internal_test