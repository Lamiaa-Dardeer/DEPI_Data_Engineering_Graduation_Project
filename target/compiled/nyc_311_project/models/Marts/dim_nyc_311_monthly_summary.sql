

WITH performance_data AS (
    SELECT * FROM `depi-graduation-project-489604`.`nyc_311_raw_data`.`fct_nyc_311_performance`
)

SELECT
    creation_month,
    complaint_type,
    -- 1. إجمالي عدد البلاغات
    COUNT(complaint_id) AS total_requests,
    
    -- 2. عدد البلاغات التي لا تزال مفتوحة
    COUNTIF(is_open_backlog = TRUE) AS open_backlog_count,
    
    -- 3. متوسط عمر الشكوى (بالأيام)
    ROUND(AVG(ticket_age_days), 2) AS avg_ticket_age,
    
    -- 4. نسبة البلاغات المتأخرة (أكثر من 5 أيام)
    ROUND(
        SAFE_DIVIDE(COUNTIF(is_late = TRUE), COUNT(complaint_id)) * 100, 
        2
    ) AS late_rate_percentage

FROM performance_data
GROUP BY 1, 2
ORDER BY creation_month, total_requests DESC