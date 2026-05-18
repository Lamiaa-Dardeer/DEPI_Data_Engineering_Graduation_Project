{{ config(materialized='table') }}

-- هذا الكود يقرأ من الجدول الخام ويخلق جدولاً جديداً تماماً لتصفير العداد
SELECT * 
FROM `depi-graduation-project-489604.nyc_311_raw_data.raw_service_requests`