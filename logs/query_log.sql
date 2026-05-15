-- created_at: 2026-05-15T00:55:02.676899300+00:00
-- finished_at: 2026-05-15T00:55:04.241629200+00:00
-- elapsed: 1.6s
-- outcome: error
-- error vendor code: -2147483648
-- error message: Unknown: [BigQuery] googleapi: Error 400: Unrecognized name: time_period at [18:9], invalidQuery (Query: https://console.cloud.google.com/bigquery?project=depi-graduation-project-489604&j=bq:US:HncEppGEv4Nn0nOJVb34Ps0brP0&page=queryresults)
-- dialect: bigquery
-- node_id: test.nyc_311_project.accepted_values_fct_nyc_311_performance_time_period__Morning__Afternoon__Evening__Night.cd0727e3af
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.accepted_values_fct_nyc_311_performance_time_period__Morning__Afternoon__Evening__Night.cd0727e3af", "profile_name": "default", "target_name": "dev"} */

    
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



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.670205400+00:00
-- finished_at: 2026-05-15T00:55:06.665703700+00:00
-- elapsed: 4.0s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_is_late.692386874f
-- query_id: UYaevdgDgY3DCHondSNZGGOCsno
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_is_late.692386874f", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_late
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where is_late is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.675291600+00:00
-- finished_at: 2026-05-15T00:55:06.743811+00:00
-- elapsed: 4.1s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_date_key.e98ed30124
-- query_id: VINyiTyCzrfXUK4OmiKVV8heFTa
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_date_key.e98ed30124", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_key
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where date_key is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.678504500+00:00
-- finished_at: 2026-05-15T00:55:06.937320300+00:00
-- elapsed: 4.3s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_location_key.751b0d1a44
-- query_id: 5b3AsD7zai9JnGH6C5wZLqq113l
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_location_key.751b0d1a44", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select location_key
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where location_key is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.671790600+00:00
-- finished_at: 2026-05-15T00:55:06.939939300+00:00
-- elapsed: 4.3s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_complaint_type_key.bb1c2f438b
-- query_id: XsywLTctcXs8R5ECdE1EhY9noww
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_complaint_type_key.bb1c2f438b", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select complaint_type_key
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where complaint_type_key is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.666863600+00:00
-- finished_at: 2026-05-15T00:55:06.950834400+00:00
-- elapsed: 4.3s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_is_open_backlog.0ead6d5b27
-- query_id: EOds5e0EXEloSYs1UroS7858xlr
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_is_open_backlog.0ead6d5b27", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_open_backlog
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where is_open_backlog is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.668491700+00:00
-- finished_at: 2026-05-15T00:55:07.553684200+00:00
-- elapsed: 4.9s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.unique_fct_nyc_311_performance_complaint_id.8754e738de
-- query_id: It90N0dwqdi9zjPCYJMxxSUgyAw
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.unique_fct_nyc_311_performance_complaint_id.8754e738de", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with dbt_test__target as (

  select complaint_id as unique_field
  from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
  where complaint_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.673800+00:00
-- finished_at: 2026-05-15T00:55:07.589816800+00:00
-- elapsed: 4.9s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.dbt_utils_expression_is_true_fct_nyc_311_performance_ticket_age_days___0.af0c958b43
-- query_id: UDg6CWtz3ipHpmdEbFr3kmKunqj
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.dbt_utils_expression_is_true_fct_nyc_311_performance_ticket_age_days___0.af0c958b43", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`

where not(ticket_age_days >= 0)


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-05-15T00:55:02.665553500+00:00
-- finished_at: 2026-05-15T00:55:08.570047600+00:00
-- elapsed: 5.9s
-- outcome: success
-- dialect: bigquery
-- node_id: test.nyc_311_project.not_null_fct_nyc_311_performance_complaint_id.86af9c5d23
-- query_id: eeAajbrxd1FqmYUR1PkVhfVNRTx
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.nyc_311_project.not_null_fct_nyc_311_performance_complaint_id.86af9c5d23", "profile_name": "default", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select complaint_id
from `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
where complaint_id is null



  
  
      
    ) dbt_internal_test;
