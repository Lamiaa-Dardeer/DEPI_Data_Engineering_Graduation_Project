-- created_at: 2026-05-15T12:09:39.708596+00:00
-- finished_at: 2026-05-15T12:09:43.685121400+00:00
-- elapsed: 4.0s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: xjU1khZB6JonS79eWBSYanVira8
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */

    select distinct schema_name from `depi-graduation-project-489604`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2026-05-15T12:09:43.715350700+00:00
-- finished_at: 2026-05-15T12:09:47.635153200+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.fct_nyc_311_performance
-- query_id: 5rlLtHzlt3YyFR5DNOl7n3R32za
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `depi-graduation-project-489604`.`nyc_311_raw_data`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2026-05-15T12:09:47.957639200+00:00
-- finished_at: 2026-05-15T12:09:56.605974100+00:00
-- elapsed: 8.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.fct_nyc_311_performance
-- query_id: oSmzVoupWICLHnUwENWBYEPXnPF
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.nyc_311_project.fct_nyc_311_performance", "profile_name": "default", "target_name": "dev"} */

  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
      
    
    

    
    OPTIONS()
    as (
      

WITH staging_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
),
dim_complaint AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
),
dim_loc AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_locations`
),
dim_agency AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_agency`
)

SELECT
    s.complaint_id,
    -- ربط التاريخ
    CAST(FORMAT_DATE('%Y%m%d', s.created_at) AS INT64) AS date_key,
    
    -- ربط الأبعاد مع معالجة مفتاح الموقع المفقود
    COALESCE(dc.complaint_type_key, FARM_FINGERPRINT('Unknown')) AS complaint_type_key,
    COALESCE(dl.location_key, FARM_FINGERPRINT('Unknown00000')) AS location_key,
    COALESCE(da.agency_key, FARM_FINGERPRINT('Unknown00000')) AS agency_key,    
    s.complaint_status,
    s.created_at,
    s.closed_at,
   
    -- ترك الحساب كما هو (سيُظهر القيم السالبة)
    DATE_DIFF(COALESCE(DATE(s.closed_at), CURRENT_DATE()), DATE(s.created_at), DAY) AS ticket_age_days,

    CASE 
        WHEN DATE_DIFF(COALESCE(DATE(s.closed_at), CURRENT_DATE()), DATE(s.created_at), DAY) > 5 THEN TRUE 
        ELSE FALSE 
    END AS is_late,

    CASE 
        WHEN s.closed_at IS NULL THEN TRUE 
        ELSE FALSE 
    END AS is_open_backlog,

    CASE 
        WHEN EXTRACT(HOUR FROM s.created_at) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM s.created_at) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM s.created_at) BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Night'
    END AS time_period

FROM staging_data s
LEFT JOIN dim_complaint dc ON s.complaint_type = dc.complaint_type
LEFT JOIN dim_loc dl ON s.borough = dl.borough AND s.zip_code = dl.zip_code
LEFT JOIN dim_agency da ON s.agency_code = da.agency_code
    );
  ;
