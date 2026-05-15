
  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`dim_locations`
      
    
    

    
    OPTIONS()
    as (
      

WITH raw_locations AS (
    SELECT DISTINCT 
        borough,
        zip_code  -- تأكدي أن الاسم هنا هو zip_code كما عدلتِه في الـ Staging
    FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
    WHERE borough IS NOT NULL OR zip_code IS NOT NULL
)

SELECT
    -- تحويل كل القيم إلى STRING قبل دمجها لضمان نجاح الـ Hash
    FARM_FINGERPRINT(
        CONCAT(
            COALESCE(CAST(borough AS STRING), 'Unknown'), 
            COALESCE(CAST(zip_code AS STRING), '00000')
        )
    ) AS location_key,
    borough,
    zip_code
FROM raw_locations
    );
  