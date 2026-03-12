# 🚀 Project: Data Modeling with dbt and BigQuery
**DEPI Graduation Project - Data Engineering Track**

## 📋 Project Overview
This project focuses on building a modern data transformation pipeline. We use **BigQuery** as our Data Warehouse and **dbt (data build tool)** for transforming raw data into clean, analytics-ready models, following software engineering best practices like modularity and testing.

# 🚀 Automated Data Pipeline & Maintenance
To overcome the Google BigQuery Sandbox 60-day expiration policy, I implemented a robust automation workflow using dbt (Data Build Tool) and GitHub Actions.

How it works:
Orchestration: A GitHub Actions workflow is scheduled to run weekly.

Security: Authentication is handled securely via Workload Identity Federation, eliminating the need for sensitive JSON keys.

Data Transformation: The system uses dbt run --full-refresh to recreate the core datasets, effectively resetting the expiration timer while maintaining data integrity.

Reliability: This ensures that the 2M+ air quality records remain available for analysis throughout the duration of the graduation project.

---

## 🏗️ Project Architecture & Milestones

### 📍 Milestone 1: Data Collection & Exploration
* **Source:** [---------------].
* **Ingestion:** Loading raw data into **Google BigQuery** (Bronze Layer).
* **Exploration:** Initial SQL queries to understand data distribution and quality.

### 📍 Milestone 2: Model Development (dbt)
* **Staging:** Cleaning and renaming raw fields.
* **Intermediate/Mart:** Applying business logic (Joins, Aggregations).
* **Testing:** Implementing `unique`, `not_null`, and custom tests to ensure data integrity.

### 📍 Milestone 3: Deployment & Orchestration
* **Batch Processing:** Setting up dbt runs on a schedule.
* **Environment:** Production vs. Development schemas in BigQuery.

### 📍 Milestone 4: MLOps & Monitoring
* **Lineage:** Tracking data flow from source to final dashboard.
* **CI/CD:** Automated testing using dbt Cloud or GitHub Actions.

### 📍 Milestone 5: Documentation & Results
* **dbt Docs:** Auto-generated documentation for all models.
* **Key Metrics:** [---------------].

---

## 🛠️ Tech Stack
* **Data Warehouse:** Google BigQuery
* **Transformation Tool:** dbt (Core/Cloud)
* **Language:** SQL & Python
* **Version Control:** GitHub

---

## 👥 Team Members
* **Aliaa Raafat Anwar Elbaz** (https://github.com/aliaelbaz)
* **Elsayed Hussein Mohamed Gouda** (https://github.com/godajr)
* **Lamiaa Mohammad Abdulhameed Dardeer** (https://github.com/Lamiaa-Dardeer)
* **Makary Makeen Makary** (https://github.com/MakaryMakeen10)

---
*Generated as part of the Digital Egypt Pioneers Initiative (DEPI).*
