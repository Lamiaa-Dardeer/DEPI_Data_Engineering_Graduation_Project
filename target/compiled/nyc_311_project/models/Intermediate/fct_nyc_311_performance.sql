

WITH staging_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
),

-- 1. استدعاء الأبعاد لربطها
dim_complaint AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
),

dim_loc AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_locations`
)

SELECT
    -- المفاتيح الأساسية للربط (Foreign Keys)
    s.complaint_id,
    CAST(FORMAT_DATE('%Y%m%d', s.created_at) AS INT64) AS date_key, -- يربط مع dim_date
    dc.complaint_type_key,                                         -- يربط مع dim_complaint_types
    dl.location_key,                                               -- يربط مع dim_locations
    
    -- البيانات التشغيلية
    s.complaint_status,
    s.created_at,
    s.closed_at,
    
    -- المقاييس (Measures) التي سنحللها
    DATE_DIFF(COALESCE(DATE(s.closed_at), CURRENT_DATE()), DATE(s.created_at), DAY) AS ticket_age_days,

    CASE 
        WHEN DATE_DIFF(COALESCE(DATE(s.closed_at), CURRENT_DATE()), DATE(s.created_at), DAY) > 5 THEN TRUE 
        ELSE FALSE 
    END AS is_late,

    CASE 
        WHEN s.closed_at IS NULL THEN TRUE 
        ELSE FALSE 
    END AS is_open_backlog,

    -- وقت اليوم لا يزال مهماً في الفاكت للتحليل الدقيق
    EXTRACT(HOUR FROM s.created_at) AS creation_hour

FROM staging_data s
-- الربط مع الأبعاد لجلب المفاتيح
LEFT JOIN dim_complaint dc 
    ON s.complaint_type = dc.complaint_type
LEFT JOIN dim_loc dl 
    ON s.borough = dl.borough 
    AND s.zip_code = dl.zip_code