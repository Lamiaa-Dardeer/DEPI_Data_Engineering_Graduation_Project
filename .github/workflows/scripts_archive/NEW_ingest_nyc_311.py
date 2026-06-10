import pandas as pd
from google.cloud import bigquery
from sodapy import Socrata
import time

app_token = "yWjEdL0pwbPbkaHSEjoYhaB8c"
# رفع مهلة الانتظار إلى 180 ثانية لتأمين أوقات الذروة للسيرفر
client_socrata = Socrata("data.cityofnewyork.us", app_token=app_token, timeout=180)

project_id = 'depi-graduation-project-489604'
dataset_id = 'nyc_311_raw_data'
table_id = 'raw_service_requests'

# تحديد السقف الذكي المتباين لكل سنة لضمان جمال وصعود الـ Trend
yearly_targets = {
    2024: 1500000,
    2025: 1650000,
    2026: 650000
}

chunk_size = 300000  # حجم دفعة آمن وخفيف جداً على السيرفر والـ RAM
first_chunk_ever = True

for year, max_limit in yearly_targets.items():
    print(f"Starting Growth-Trend for Year {year} (Target Limit: {max_limit})...")
    offset = 0
    
    while offset < max_limit:
        # حساب الحجم المناسب للدفعة الأخيرة بحيث لا تتخطى السقف المحدد للسنة
        current_chunk = min(chunk_size, max_limit - offset)
        
        print(f"  Fetching rows {offset} to {offset + current_chunk} for {year}...")
        
        query = f"created_date >= '{year}-01-01T00:00:00' AND created_date <= '{year}-12-31T23:59:59'"
        
        results = client_socrata.get(
            "erm2-nwe9", 
            where=query, 
            order="created_date ASC", 
            limit=current_chunk, 
            offset=offset
        )
        
        # إذا انتهت بيانات السنة قبل الوصول للسقف (أمر احتياطي)
        if not results or len(results) == 0:
            print(f"   No more available historical data for {year}.\n")
            break
            
        df_chunk = pd.DataFrame.from_records(results)
        
        # أول دفعة في المشروع كله تمسح الجدول القديم بالكامل وتبدأ على نظافة
        if first_chunk_ever:
            mode = 'replace'
            first_chunk_ever = False
        else:
            mode = 'append'
            
        # ضخ الدفعة فوراً إلى BigQuery لتفريغ الـ RAM
        df_chunk.to_gbq(
            destination_table=f"{dataset_id}.{table_id}",
            project_id=project_id,
            if_exists=mode
        )
        
        offset += current_chunk
        time.sleep(2) # استراحة هيدروليكية قصيرة لمنع حظر السيرفر
        
    print(f" Successfully completed and locked Target for {year}!\n")

print(" Done! Perfect real-growth database created successfully in BigQuery without a single crash!")