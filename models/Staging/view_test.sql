{{ config(materialized='view') }} 
WITH stg_data AS (
    SELECT * FROM {{ ref('stg_nyc_311_requests') }}
)


select
    complaint_id,
    count(*) as cnt
from stg_data
group by complaint_id
having count(*) > 1
limit 10
