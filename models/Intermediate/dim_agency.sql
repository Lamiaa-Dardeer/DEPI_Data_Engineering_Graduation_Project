{{ config(materialized='table') }}


    with unique_agency AS (
        SELECT DISTINCT 
            agency_code,agency_name
        FROM {{ ref('stg_nyc_311_requests') }}
        WHERE agency_code IS NOT NULL
    )

    SELECT 
    farm_fingerprint(agency_code) AS agency_key,
    agency_code,
    agency_name 

     FROM unique_agency
