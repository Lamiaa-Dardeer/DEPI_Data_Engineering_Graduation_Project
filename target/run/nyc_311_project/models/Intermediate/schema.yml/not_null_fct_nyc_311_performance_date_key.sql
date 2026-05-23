
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_key
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where date_key is null



  
  
      
    ) dbt_internal_test