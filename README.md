# Project: NYC 311 Data Modeling & Automated Pipeline
**DEPI Graduation Project - Data Engineering Track**

##  Project Overview
This project focuses on building an end-to-end modern data transformation pipeline. We use **Google BigQuery** as our Cloud Data Warehouse and **dbt (data build tool)** for transforming raw, complex data into highly optimized, analytics-ready models following software engineering best practices like modularity, version control, and data testing.

---

##  Project Architecture & Data Flow



###  Phase 1: Data Ingestion & Historic Load (Bronze Layer)
* **Source:** New York City Open Data Portal (NYC 311 Service Requests).
* **Initial Load:** A specialized Python script (`scripts/ingest_nyc_311.py`) was used to ingest **1.5+ Million rows** of historical data from **2020 to the present** via the Socrata Open Data API directly into BigQuery.

###  Phase 2: Cost-Effective Automation & Sandbox Maintenance
To overcome the Google BigQuery Sandbox 60-day table expiration policy without incurring network costs or draining GitHub Actions runtime minutes, a highly optimized orchestration strategy was implemented:
* **Orchestration:** A GitHub Actions workflow is scheduled to run automatically **every Sunday** (`cron: '0 0 * * 0'`).
* **Security:** Authentication with Google Cloud is handled securely via **Workload Identity Federation**, eliminating the need for sensitive, hardcoded JSON service account keys.
* **The Smart SQL Refresh (Counteracting Expiration):** Instead of re-downloading millions of rows via API every week, the workflow triggers a dbt model (`raw_service_requests.sql`) that reads the existing historical table and completely overwrites it internally inside BigQuery. This "touch" operation completely resets BigQuery's 60-day expiration timer in just a few seconds.

###  Phase 3: Dimensional Data Modeling (dbt - Silver & Gold Layers)
* **Staging:** Cleaning, casting data types, and renaming raw fields.
* **Intermediate:** Building enterprise-grade business logic. A dedicated **Star Schema** architecture was designed by decoupling entities into specific dimensional models:
  * `dim_date`: Temporal analytics.
  * `dim_locations`: Geographical analysis of complaints.
  * `dim_complaint_types`: Categorizing the nature of service requests.
  * `dim_agency`: Analyzing specific agency performance (e.g., NYPD, DOT, DSNY).
* **Fact Table (`fct_nyc_311_performance`):** The central hub joining all dimensions to track resolution times, SLAs, and operational performance metrics.
* **Data Quality & Testing:** Implementing automated schema tests (`unique`, `not_null`) via `schema.yml` to maintain data integrity across the pipeline.

###  Phase 4: BI Analytics & Visualization (Gold Layer)
* **Tool:** Microsoft Power BI.
* **Design & Insights:** A specialized dark-themed dashboard leveraging the iconic **NYC Taxi Yellow** color palette. It tracks long-term historical trends (2020-2026), Year-over-Year (YoY) operational performance, agency response efficiency, and complaint seasonality patterns.

---

## Tech Stack
* **Data Warehouse:** Google BigQuery
* **Transformation & Modeling:** dbt Core
* **Orchestration / CI-CD:** GitHub Actions
* **Language:** SQL (BigQuery Standard SQL) & Python (Initial Ingestion)
* **BI & Visualization:** Microsoft Power BI

-------------------
## Archived Ingestion Scripts

This folder (scripts_archive) contains legacy ingestion scripts used initially
to pull NYC 311 raw data from the public API.

These scripts are kept for:
- Documentation
- Historical reference
- Demonstration purposes

The active analytics pipeline currently depends on BigQuery + dbt models.
-------------------
## Team Members
* **Aliaa Raafat Anwar Elbaz** ([GitHub](https://github.com/aliaelbaz))
* **Elsayed Hussein Mohamed Gouda** ([GitHub](https://github.com/godajr))
* **Lamiaa Mohammad Abdulhameed Dardeer** ([GitHub](https://github.com/Lamiaa-Dardeer))
* **Makary Makeen Makary** ([GitHub](https://github.com/MakaryMakeen10))

---
*Generated as part of the Digital Egypt Pioneers Initiative (DEPI).*
