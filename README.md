# NYC 311 Data Modeling and Automated Pipeline
**DEPI Graduation Project - Data Engineering Track**

## Project Overview
This project focuses on building an end-to-end data transformation pipeline. We use Google BigQuery as our Cloud Data Warehouse and dbt Core to transform raw, complex data into optimized, analytics-ready models. The project follows standard software engineering practices like modularity, version control, and automated data testing.

---

## Project Deliverables and Links
All project assets, presentation slides, and technical workflows are fully documented and accessible below:
* **Interactive Data Catalog:** [Click Here to View Live dbt Documentation Website](https://lamiaa-dardeer.github.io/DEPI_Data_Engineering_Graduation_Project/)
* **Graduation Presentation:** [Download Project Presentation Slides](./docs/DEPI_Data_Engineering_Graduation_Presentation_2026.pptx)
* **Power BI Dashboard:** (___________________________________________________________________________________________)
* **Production Workflows:** [View GitHub Actions CI/CD Pipeline Code](./.github/workflows/nyc_311_refresh.yml)

---

## Project Architecture and Data Flow

### Phase 1: Data Ingestion and Historic Load (Bronze Layer)
* **Source:** New York City Open Data Portal (NYC 311 Service Requests).
* **Initial Load:** We used a specialized Python script to pull over 6.5 Million rows of historical data from 2024 to the present via the Socrata Open Data API directly into BigQuery.
* **Ingestion Code:** The historical pipeline script can be reviewed directly in the repository at [./.github/workflows/scripts_archive/NEW_ingest_nyc_311.py](.github/workflows/scripts_archive/NEW_ingest_nyc_311.py).

### Phase 2: Cost-Effective Automation and Sandbox Maintenance
To handle the Google BigQuery Sandbox 60-day table expiration policy without paying for storage or wasting GitHub Actions runtime minutes, we built a smart orchestration strategy:
* **Orchestration:** A GitHub Actions workflow is scheduled to run automatically every Sunday (cron: '0 0 * * 0').
* **Security:** Authentication with Google Cloud is handled via Workload Identity Federation (WIF). This provides secure, password-less access and eliminates the need for hardcoded JSON service account keys.
* **The Smart SQL Refresh:** Instead of downloading millions of rows via API every week, the workflow runs a dbt model that reads the existing historical table and completely overwrites it internally inside BigQuery. This operation resets BigQuery's 60-day expiration timer in just a few seconds.

### Phase 3: Dimensional Data Modeling (dbt - Silver and Gold Layers)
* **Staging:** Cleaning data, casting data types, and renaming raw fields for consistency.
* **Intermediate:** Building core business logic using a Star Schema architecture to separate entities into dimension tables:
  * dim_date: For temporal and seasonal analytics.
  * dim_locations: For geographical analysis of complaints.
  * dim_complaint_types: For categorizing the nature of service requests.
  * dim_agency: For analyzing specific agency performance.
* **Fact Table (fct_nyc_311_performance):** The central table joining all dimensions to track ticket resolution times, SLAs, and overall operational efficiency.
* **Data Quality and Testing:** We implemented automated schema tests (unique and not_null) via schema.yml to maintain data integrity across the entire pipeline.
* **Automated Documentation:** We integrated `dbt docs generate` into our GitHub Actions workflow. This automatically publishes our interactive data dictionary and data lineage graph to a public endpoint whenever changes are pushed.

### Phase 4: BI Analytics and Visualization (Gold Layer)
* **Tool:** Microsoft Power BI.
* **Design and Insights:** We designed a dark-themed dashboard using the NYC Taxi Yellow color palette. It tracks historical trends (2024-2026), Year-over-Year (YoY) performance, agency response times, and seasonal complaint patterns.
* https://drive.google.com/file/d/18f2Ms-SClwqQqv4rhrtyEwk8IgSA6epi/view

---

## Tech Stack
* **Data Warehouse:** Google BigQuery
* **Transformation and Modeling:** dbt Core
* **Orchestration / CI-CD:** GitHub Actions
* **Languages:** SQL (BigQuery Standard SQL) and Python (Initial Ingestion)
* **BI and Visualization:** Microsoft Power BI

---

## Repository Structure
```text
├── .github/workflows/
│   └── nyc_311_refresh.yml      # CI/CD Automated GitHub Actions Pipeline
├── docs/
│   ├── DEPI_Data_Engineering_Graduation_Presentation_2026.pptx   # Project Slides
│   └── NYC_311_Performance_Dashboard.zip                         # Power BI Project
├── models/
│   ├── Intermediate/            # Dimensional Modeling (Star Schema)
│   ├── Marts/                   # Analytics-ready Business Gold Datasets
│   └── Staging/                 # Raw Base Views and Cleaning Layer
└── scripts_archive/             # Legacy Ingestion Python Scripts

```

## Team Members
* Aliaa Raafat Anwar Elbaz ([GitHub](https://github.com/aliaelbaz))
* Elsayed Hussein Mohamed Gouda ([GitHub](https://github.com/godajr))
* Lamiaa Mohammad Abdulhameed Dardeer ([GitHub](https://github.com/Lamiaa-Dardeer))
* Makary Makeen Makary ([GitHub](https://github.com/MakaryMakeen10))

---
*Generated as part of the Digital Egypt Pioneers Initiative (DEPI).*
