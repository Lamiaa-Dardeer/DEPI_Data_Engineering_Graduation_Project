{{ config(materialized='view') }} -- طبقة الـ Staging يفضل أن تكون View لتوفير المساحة

WITH raw_data AS (
    SELECT distinct * FROM {{ ref('raw_service_requests') }} -- هنا dbt سيفهم أنه يقرأ من الجدول الذي قمنا بحمايته
)

SELECT
    -- تحويل المعرف ليكون نصاً فريداً
    CAST(unique_key AS STRING) AS complaint_id,
    
    -- ضبط التواريخ لتكون Timestamp
    CAST(created_date AS TIMESTAMP) AS created_at,
    CAST(closed_date AS TIMESTAMP) AS closed_at,
    
    -- تنظيف الأسماء
    agency AS agency_code,
    agency_name,
    complaint_type,
    descriptor AS complaint_description,
    status AS complaint_status,
    
    -- بيانات الموقع
    incident_zip AS zip_code,
    city,
    borough,
    latitude,
    longitude

FROM raw_data
WHERE created_date IS NOT NULL -- استبعاد البيانات غير المكتملة