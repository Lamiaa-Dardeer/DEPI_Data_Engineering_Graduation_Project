
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select complaint_id
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
where complaint_id is null



  
  
      
    ) dbt_internal_test