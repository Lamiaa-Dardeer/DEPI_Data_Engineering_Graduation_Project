
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select complaint_type_key
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
where complaint_type_key is null



  
  
      
    ) dbt_internal_test