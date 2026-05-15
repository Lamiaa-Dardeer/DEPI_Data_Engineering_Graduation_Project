-- created_at: 2026-05-15T12:30:24.377632300+00:00
-- finished_at: 2026-05-15T12:30:28.746466300+00:00
-- elapsed: 4.4s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: n24EzZWwktIHqeEH3xuGYFVJZCL
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */

    select distinct schema_name from `depi-graduation-project-489604`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2026-05-15T12:30:28.763517900+00:00
-- finished_at: 2026-05-15T12:30:33.074927600+00:00
-- elapsed: 4.3s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_agency
-- query_id: y9bNrhHGU5XA52FTcegmezRDfOG
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `depi-graduation-project-489604`.`nyc_311_raw_data`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2026-05-15T12:30:33.420481100+00:00
-- finished_at: 2026-05-15T12:30:39.987539900+00:00
-- elapsed: 6.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_agency
-- query_id: a8XNQfIlE8ZtsWCFfgrBmZEkGWA
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.nyc_311_project.dim_agency", "profile_name": "default", "target_name": "dev"} */

  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_agency`
      
    
    

    
    OPTIONS()
    as (
      


    with unique_agency AS (
        SELECT DISTINCT 
            agency_code,agency_name
        FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
        WHERE agency_code IS NOT NULL
    )

    SELECT 
    farm_fingerprint(agency_code) AS agency_key,
    agency_code,
    agency_name 

     FROM unique_agency
    );
  ;
