{{ config(materialized='table') }}

-- هذا السطر يقرأ البيانات من جدولك الحالي ويصنع منه نسخة جديدة
-- النسخة الجديدة ستحصل على 60 يوماً إضافية تلقائياً
SELECT 
    * FROM 
    `depi-graduation-project-489604.staging_area.pollution_raw_data`
