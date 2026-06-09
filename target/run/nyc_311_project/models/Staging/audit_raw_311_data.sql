
  
    

    create or replace table `depi-graduation-project-489604`.`nyc_311_raw_data`.`audit_raw_311_data`
      
    
    

    OPTIONS()
    as (
      -- هذا الموديل للاستكشاف فقط وليس جزءاً من الـ Final Pipeline


WITH base_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`raw_service_requests`
),

column_stats AS (
    SELECT 
        'bridge_highway_name' as column_name, 
        count(bridge_highway_name) as non_null_count,
        count(DISTINCT bridge_highway_name) as unique_values,
        round(count(bridge_highway_name) / count(*) * 100, 2) as completeness_pct
    FROM base_data

    UNION ALL

    SELECT 
        'taxi_pick_up_location', 
        count(taxi_pick_up_location),
        count(DISTINCT taxi_pick_up_location),
        round(count(taxi_pick_up_location) / count(*) * 100, 2)
    FROM base_data

    UNION ALL

    SELECT 
        'vehicle_type', 
        count(vehicle_type),
        count(DISTINCT vehicle_type),
        round(count(vehicle_type) / count(*) * 100, 2)
    FROM base_data

    UNION ALL

    SELECT 
        'facility_type', 
        count(facility_type),
        count(DISTINCT facility_type),
        round(count(facility_type) / count(*) * 100, 2)
    FROM base_data
    
    UNION ALL

    SELECT 
        'agency', -- سنقارنه بـ agency_name لنرى التكرار
        count(agency),
        count(DISTINCT agency),
        round(count(agency) / count(*) * 100, 2)
    FROM base_data

    UNION ALL
    SELECT 'street_name', count(street_name), count(DISTINCT street_name), round(count(street_name) / count(*) * 100, 2) 
    FROM base_data

    UNION ALL
    SELECT 'latitude', count(latitude), count(DISTINCT latitude), round(count(latitude) / count(*) * 100, 2) 
    FROM base_data
    
)

SELECT * FROM column_stats
ORDER BY completeness_pct DESC
    );
  