import pandas as pd
from google.cloud import bigquery
from sodapy import Socrata

# 1. إعداد الاتصال
client_socrata = Socrata("data.cityofnewyork.us", None)
project_id = 'depi-graduation-project-489604'
dataset_id = 'nyc_311_raw_data'
table_id = 'raw_service_requests'

# تحديد السنوات المستهدفة للمشروع وحجم العينة لكل سنة
years = [2023, 2024, 2025, 2026]
limit_per_year = 350000  # 350 ألف صف من كل سنة = الإجمالي حوالي 1.4 مليون صف منظم

all_data = []

for year in years:
    print(f"Ingesting data for year {year}...")
    
    # صياغة استعلام زمني دقيق لكل سنة مع الترتيب التلقائي للتأكد من جلب البيانات
    query = f"created_date >= '{year}-01-01T00:00:00' AND created_date <= '{year}-12-31T23:59:59'"
    
    # استخدام order='created_date ASC' لضمان جلب البيانات بالتسلسل الزمني الصحيح
    results = client_socrata.get("erm2-nwe9", where=query, order="created_date ASC", limit=limit_per_year)
    
    df_year = pd.DataFrame.from_records(results)
    print(f"-> Successfully fetched {len(df_year)} rows for {year}.")
    
    if not df_year.empty:
        all_data.append(df_year)

# دمج جداول السنوات كلها في جدول واحد كبير
final_df = pd.concat(all_data, ignore_index=True)

# 4. رفع البيانات الكلية إلى BigQuery وتصفير العداد
final_df.to_gbq(
    destination_table=f"{dataset_id}.{table_id}",
    project_id=project_id,
    if_exists='replace'
)

print(f"\n  Done! Ingested a total of {len(final_df)} structured rows into BigQuery.")