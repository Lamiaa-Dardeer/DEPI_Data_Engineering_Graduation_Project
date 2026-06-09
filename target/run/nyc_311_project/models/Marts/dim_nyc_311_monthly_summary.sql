
  
    

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
    -- إذا لم تكن هناك بلاغات أصلاً في الشهر، نكتب 'No Requests' بدلاً من أن نوحي بوجود شكوى مجهولة
    CASE 
        WHEN COUNT(f.complaint_id) = 0 THEN 'No Requests'
        ELSE COALESCE(c.complaint_category, 'Unknown')
    END AS complaint_category,

    CASE 
        WHEN COUNT(f.complaint_id) = 0 THEN 'No Requests'
        ELSE COALESCE(c.priority_level, 'Unknown')
    END AS priority_level,
    
    IFNULL(COUNT(f.complaint_id), 0) AS total_requests,
    IFNULL(COUNTIF(f.is_late = TRUE), 0) AS late_requests_count,
    ROUND(AVG(f.ticket_age_days), 2) AS avg_ticket_age,
    
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(c.priority_level = 'High' AND f.is_open_backlog = FALSE),
            COUNTIF(c.priority_level = 'High')
        ) * 100, 2
    ) AS high_priority_resolution_rate

FROM dim_date d
LEFT JOIN fact_data f ON d.date_key = f.date_key
LEFT JOIN dim_complaint c ON f.complaint_type_key = c.complaint_type_key

GROUP BY d.month_name, d.year, c.complaint_category, c.priority_level

ORDER BY d.year, d.month_name
    );
  