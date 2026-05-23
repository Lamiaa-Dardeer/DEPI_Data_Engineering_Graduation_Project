
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_late
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where is_late is null



  
  
      
    ) dbt_internal_test