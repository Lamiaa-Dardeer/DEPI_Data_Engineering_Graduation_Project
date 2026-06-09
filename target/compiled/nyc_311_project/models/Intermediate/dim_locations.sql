

WITH cleaned_locations AS (
    SELECT DISTINCT
        COALESCE(CAST(borough AS STRING), 'Unknown') AS borough,
        COALESCE(CAST(zip_code AS STRING), '00000') AS zip_code
    FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`stg_nyc_311_requests`
    WHERE borough IS NOT NULL OR zip_code IS NOT NULL
)

SELECT
    FARM_FINGERPRINT(CONCAT(borough, '|', zip_code)) AS location_key,
    borough,
    zip_code
FROM cleaned_locations