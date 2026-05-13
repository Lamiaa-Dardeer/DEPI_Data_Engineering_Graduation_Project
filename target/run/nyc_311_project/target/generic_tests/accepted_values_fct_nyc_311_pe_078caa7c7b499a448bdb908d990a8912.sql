
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        time_period as value_field,
        count(*) as n_records

    from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
    group by time_period

)

select *
from all_values
where value_field not in (
    'Morning','Afternoon','Evening','Night'
)



  
  
      
    ) dbt_internal_test