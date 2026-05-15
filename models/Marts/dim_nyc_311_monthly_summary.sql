{{ config(materialized='table') }}

WITH fact_data AS (
    SELECT * FROM {{ ref('fct_nyc_311_performance') }}
),
dim_complaint AS (
    SELECT * FROM {{ ref('dim_complaint_types') }}
),
dim_date AS (
    SELECT * FROM {{ ref('dim_date') }}
)

SELECT
    d.month_name,
    d.year,
    c.complaint_category,
    c.priority_level,
    
    -- 1. إجمالي عدد البلاغات
    COUNT(f.complaint_id) AS total_requests,
    
    -- 2. عدد البلاغات المتأخرة
    COUNTIF(f.is_late = TRUE) AS late_requests_count,
    
    -- 3. متوسط عمر الشكوى (سيظهر القيم السالبة كما اتفقنا للتحليل)
    ROUND(AVG(f.ticket_age_days), 2) AS avg_ticket_age,
    
    -- 4. نسبة البلاغات ذات الأولوية القصوى التي تم إغلاقها
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(c.priority_level = 'High' AND f.is_open_backlog = FALSE), 
            COUNTIF(c.priority_level = 'High')
        ) * 100, 2
    ) AS high_priority_resolution_rate

FROM fact_data f
JOIN dim_complaint c ON f.complaint_type_key = c.complaint_type_key
JOIN dim_date d ON f.date_key = d.date_key

GROUP BY 1, 2, 3, 4
ORDER BY d.year DESC, d.month_name, total_requests DESC