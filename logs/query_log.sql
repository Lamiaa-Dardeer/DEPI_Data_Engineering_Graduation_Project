-- created_at: 2026-05-15T02:06:22.886800800+00:00
-- finished_at: 2026-05-15T02:06:26.954086+00:00
-- elapsed: 4.1s
-- outcome: success
-- dialect: bigquery
-- node_id: not available
-- query_id: vtAekAhUM7ONkfSPNM873hxMQQM
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */

    select distinct schema_name from `depi-graduation-project-489604`.INFORMATION_SCHEMA.SCHEMATA;
  ;
-- created_at: 2026-05-15T02:06:26.984499100+00:00
-- finished_at: 2026-05-15T02:06:30.978515+00:00
-- elapsed: 4.0s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_nyc_311_monthly_summary
-- query_id: 2J6Jj2NI2erYUvpfIgpLGw7KJei
-- desc: get_relation > list_relations call
SELECT
    table_catalog,
    table_schema,
    table_name,
    table_type
FROM 
    `depi-graduation-project-489604`.`nyc_311_raw_data`.INFORMATION_SCHEMA.TABLES;
-- created_at: 2026-05-15T02:06:31.321830500+00:00
-- finished_at: 2026-05-15T02:06:35.950205+00:00
-- elapsed: 4.6s
-- outcome: success
-- dialect: bigquery
-- node_id: model.nyc_311_project.dim_nyc_311_monthly_summary
-- query_id: b1E3bca0ep9hSqvRkFaw5DYhlrh
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.nyc_311_project.dim_nyc_311_monthly_summary", "profile_name": "default", "target_name": "dev"} */

  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_nyc_311_monthly_summary`
      
    
    

    
    OPTIONS()
    as (
      

WITH fact_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
),
dim_complaint AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
),
dim_date AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_date`
)

SELECT
    d.month_name,
    d.year,
    c.complaint_category,
    c.priority_level,
    
    -- 1. إجمالي عدد البلاغات
    COUNT(f.complaint_id) AS total_requests,
    
    -- 2. عدد البلاغات المتأخرة
    COUNTIF(f.is_late = TRUE) AS late_requests_count,
    
    -- 3. متوسط عمر الشكوى (سيظهر القيم السالبة كما اتفقنا للتحليل)
    ROUND(AVG(f.ticket_age_days), 2) AS avg_ticket_age,
    
    -- 4. نسبة البلاغات ذات الأولوية القصوى التي تم إغلاقها
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(c.priority_level = 'High' AND f.is_open_backlog = FALSE), 
            COUNTIF(c.priority_level = 'High')
        ) * 100, 2
    ) AS high_priority_resolution_rate

FROM fact_data f
JOIN dim_complaint c ON f.complaint_type_key = c.complaint_type_key
JOIN dim_date d ON f.date_key = d.date_key

GROUP BY 1, 2, 3, 4
ORDER BY d.year DESC, d.month_name, total_requests DESC
    );
  ;
