{{ config(materialized='table') }}

WITH staging_data AS (
    SELECT * FROM {{ ref('stg_nyc_311_requests') }}
)

SELECT
    complaint_id,
    complaint_type,
    complaint_status,
    created_at,
    closed_at,
    
    -- 1. حساب مدة الشكوى:
    -- إذا كانت مغلقة: يحسب الفرق حتى تاريخ الإغلاق
    -- إذا كانت مفتوحة: يحسب الفرق حتى تاريخ اليوم تلقائياً
    DATE_DIFF(COALESCE(DATE(closed_at), CURRENT_DATE()), DATE(created_at), DAY) AS ticket_age_days,

    -- 2. تحديد حالة التأخير (أكثر من 5 أيام سواء مغلقة أو لا تزال مفتوحة)
    CASE 
        WHEN DATE_DIFF(COALESCE(DATE(closed_at), CURRENT_DATE()), DATE(created_at), DAY) > 5 THEN TRUE 
        ELSE FALSE 
    END AS is_late,

    -- 3. تحديد هل الشكوى لا تزال مفتوحة (Backlog)
    CASE 
        WHEN closed_at IS NULL THEN TRUE 
        ELSE FALSE 
    END AS is_open_backlog,

    EXTRACT(HOUR FROM created_at) AS creation_hour,
    FORMAT_DATE('%A', DATE(created_at)) AS creation_day_name,
    
    -- هل هو يوم عطلة؟
    CASE 
        WHEN FORMAT_DATE('%u', DATE(created_at)) IN ('6', '7') THEN TRUE 
        ELSE FALSE 
    END AS is_weekend,

    CASE 
        WHEN EXTRACT(HOUR FROM created_at) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM created_at) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM created_at) BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Night'
    END AS time_period,

    FORMAT_DATE('%B', DATE(created_at)) AS creation_month

FROM staging_data
-- أزلنا شرط الـ WHERE لكي تظهر الشكاوى المفتوحة والمغلقة معاً