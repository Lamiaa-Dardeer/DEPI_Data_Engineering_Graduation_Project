
  
    

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
    FARM_FINGERPRINT(complaint_type) AS complaint_type_key,
    complaint_type,
    
    -- 1. تصنيف المجموعات (الذي فعلناه سابقاً)
    CASE 
        WHEN complaint_type LIKE '%Noise%' THEN 'Noise Pollution'
        WHEN complaint_type LIKE '%Heat%' OR complaint_type LIKE '%Water%' THEN 'Utilities & Maintenance'
        WHEN complaint_type LIKE '%Street%' OR complaint_type LIKE '%Sidewalk%' THEN 'Infrastructure'
        WHEN complaint_type LIKE '%Vehicle%' OR complaint_type LIKE '%Traffic%' THEN 'Transportation'
        ELSE 'General Inquiry/Other'
    END AS complaint_category,

    -- 2. إضافة الأولوية (Priority)
    CASE 
        -- أولوية قصوى: تهدد الحياة أو الصحة (مثل انقطاع التدفئة في الشتاء أو تسرب مياه)
        WHEN complaint_type IN ('HEAT/HOT WATER', 'UNSANITARY CONDITION', 'Water System', 'Hazardous Materials') THEN 'High'
        -- أولوية متوسطة: تعيق الحركة أو تسبب إزعاجاً مستمراً (مثل مشاكل الشوارع أو الضوضاء المستمرة)
        WHEN complaint_type LIKE '%Noise%' OR complaint_type LIKE '%Street%' OR complaint_type LIKE '%Traffic%' THEN 'Medium'
        -- أولوية عادية: استفسارات أو مشاكل غير عاجلة
        ELSE 'Low'
    END AS priority_level

FROM unique_types
    );
  