-- created_at: 2026-05-13T08:40:21.380624100+00:00
-- finished_at: 2026-05-13T08:40:25.304908500+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: QZo6cfjZu1Ur3qNzPnCja6XSrY5
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */

    select distinct schema_name from `depi-graduation-project-489604`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2026-05-13T08:40:25.324587+00:00
-- finished_at: 2026-05-13T08:40:29.013666800+00:00
-- elapsed: 3.7s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_nyc_311_monthly_summary
-- query_id: XA7M65jVG80oHXI4YqWrXHOGuWu
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `depi-graduation-project-489604`.`nyc_311_raw_data`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2026-05-13T08:40:29.372677600+00:00
-- finished_at: 2026-05-13T08:40:34.022170600+00:00
-- elapsed: 4.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_nyc_311_monthly_summary
-- query_id: ZmCtk3U557Etb9ras1W9Fz25wUJ
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.nyc_311_project.dim_nyc_311_monthly_summary", "profile_name": "default", "target_name": "dev"} */

  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_nyc_311_monthly_summary`
      
    
    

    
    OPTIONS()
    as (
      

WITH performance_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
)

SELECT
    creation_month,
    complaint_type,
    -- 1. إجمالي عدد البلاغات
    COUNT(complaint_id) AS total_requests,
    
    -- 2. عدد البلاغات التي لا تزال مفتوحة
    COUNTIF(is_open_backlog = TRUE) AS open_backlog_count,
    
    -- 3. متوسط عمر الشكوى (بالأيام)
    ROUND(AVG(ticket_age_days), 2) AS avg_ticket_age,
    
    -- 4. نسبة البلاغات المتأخرة (أكثر من 5 أيام)
    ROUND(
        SAFE_DIVIDE(COUNTIF(is_late = TRUE), COUNT(complaint_id)) * 100, 
        2
    ) AS late_rate_percentage

FROM performance_data
GROUP BY 1, 2
ORDER BY creation_month, total_requests DESC
    );
  ;
