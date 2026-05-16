import pandas as pd
from google.cloud import bigquery
from sodapy import Socrata
from datetime import datetime

# 1. إعداد الاتصال
client_socrata = Socrata("data.cityofnewyork.us", None)
project_id = 'depi-graduation-project-489604'
dataset_id = 'nyc_311_raw_data'
table_id = 'raw_service_requests'

# 2. تحديد تاريخ البداية (2020-01-01)
# سنستخدم تنسيق ISO المعتمد في منصة Socrata
start_date = "2020-01-01T00:00:00"

# 3. صياغة الاستعلام (Query) لجلب البيانات من 2020 إلى الآن
# تم استبدال limit الثابت بفلتر زمني
# ملاحظة: سحب 6 سنوات من البيانات قد يستغرق وقتاً أطول ويزيد حجم البيانات
query = f"created_date >= '{start_date}'"

print(f"Starting data ingestion from {start_date}...")

# سحب البيانات (يمكنكِ زيادة الـ limit إذا كان حجم البيانات ضخماً جداً)
results = client_socrata.get("erm2-nwe9", where=query, limit=1500000) 

df = pd.DataFrame.from_records(results)

# 4. رفع البيانات لبيج كويري وتصفير العداد
df.to_gbq(
    destination_table=f"{dataset_id}.{table_id}",
    project_id=project_id,
    if_exists='replace'
)

print(f"Successfully ingested {len(df)} rows from 2020 onwards! to BigQuery.")  