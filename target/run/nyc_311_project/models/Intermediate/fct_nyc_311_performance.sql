
  
    

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
)

SELECT
    s.complaint_id,
    -- ربط التاريخ
    CAST(FORMAT_DATE('%Y%m%d', s.created_at) AS INT64) AS date_key,
    
    -- ربط الأبعاد مع معالجة مفتاح الموقع المفقود
    COALESCE(dc.complaint_type_key, FARM_FINGERPRINT('Unknown')) AS complaint_type_key,
    COALESCE(dl.location_key, FARM_FINGERPRINT('Unknown00000')) AS location_key,
    
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
    );
  