

WITH date_series AS (
    SELECT *
    FROM UNNEST(GENERATE_DATE_ARRAY('2023-01-01', '2026-12-31', INTERVAL 1 DAY)) AS date_day
)

SELECT
    -- المفتاح الأساسي (مثلاً: 20260513)
    CAST(FORMAT_DATE('%Y%m%d', date_day) AS INT64) AS date_key,
    date_day AS full_date,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(MONTH FROM date_day) AS month,
    FORMAT_DATE('%B', date_day) AS month_name,
    EXTRACT(DAY FROM date_day) AS day,
    EXTRACT(QUARTER FROM date_day) AS quarter,
    FORMAT_DATE('%A', date_day) AS day_name,
    -- تحديد أيام العمل (السبت والأحد عطلة في نيويورك)
    CASE 
        WHEN FORMAT_DATE('%u', date_day) IN ('6', '7') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM date_series