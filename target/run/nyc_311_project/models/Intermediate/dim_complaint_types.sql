
  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_complaint_types`
      
    
    

    
    OPTIONS()
    as (
      

WITH unique_types AS (
    SELECT DISTINCT 
        complaint_type 
    FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
    WHERE complaint_type IS NOT NULL
)

SELECT
    -- إنشاء مفتاح فريد مبني على النص نفسه (سيعطي دائماً نفس الكود لنفس النص)
    FARM_FINGERPRINT(complaint_type) AS complaint_type_key,
    complaint_type,
    
    -- إضافة تصنيفات ذكية لتسهيل التحليل
    CASE 
        WHEN complaint_type LIKE '%Noise%' THEN 'Noise Pollution'
        WHEN complaint_type LIKE '%Heat%' OR complaint_type LIKE '%Water%' THEN 'Utilities & Maintenance'
        WHEN complaint_type LIKE '%Street%' OR complaint_type LIKE '%Sidewalk%' THEN 'Infrastructure'
        WHEN complaint_type LIKE '%Vehicle%' OR complaint_type LIKE '%Traffic%' THEN 'Transportation'
        ELSE 'General Inquiry/Other'
    END AS complaint_category

FROM unique_types
    );
  