
  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`raw_service_requests`
      
    
    

    OPTIONS()
    as (
      

-- هذا الكود يقرأ من الجدول المخزن حالياً، ويعيد بناءه وتصفير عداد الـ 60 يوماً
SELECT * FROM `depi-graduation-project-489604.nyc_311_raw_data.raw_service_requests`
    );
  