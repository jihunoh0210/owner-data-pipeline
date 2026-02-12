# owner-data-pipeline
# Owner Data Pipeline

## Project Overview
This repository contains the ELT (Extract, Load, Transform) pipeline designed to process sales and marketing data for Owner. The goal of this project is to transform raw lead and opportunity data into actionable insights regarding funnel performance, conversion rates, and Customer Acquisition Cost (CAC).

## Architecture
The pipeline follows a modern **Multi-Layered Architecture** (Medallion Architecture) within Snowflake to ensure data quality and scalability.

### 1. Staging Layer (Bronze)
* **Schema:** `STAGING_JIHUNOH`
* **Purpose:** Raw data ingestion and light cleaning.
* **Approach:** Uses Views (`STG_`) to cast data types and standardize column names without duplicating raw storage.

### 2. Data Warehouse Layer (Silver)
* **Schema:** `DW_JIHUNOH`
* **Purpose:** Business logic application and dimensional modeling.
* **Structure:** Follows a Star Schema approach using `FACT_` tables (e.g., `FACT_LEADS`, `FACT_OPPORTUNITIES`) to consolidate events and measure key business processes.

### 3. Reporting Layer (Gold)
* **Schema:** `REPORTING_JIHUNOH`
* **Purpose:** Aggregated, analytics-ready tables for BI tools.
* **Key Table:** `FUNNEL_PERFORMANCE` - A "Main Source" (SSOT) designed to calculate conversion rates and win rates across different stages of the sales funnel.

## Tech Stack
* **Database:** Snowflake
* **Language:** SQL
* **Modeling Strategy:** Dimensional Modeling (Star Schema)

## Key Metrics Calculated
* **Conversion Rates:** Lead-to-Opportunity and Opportunity-to-Win ratios.
* **Win Rates:** Analysis of closed-won deals vs. total opportunities.
* **CAC Analysis:** Correlating marketing spend with acquired customers.

## How to Run
The scripts are organized by layer. To reproduce the pipeline:
1.  Run scripts in `staging/` to create base views.
2.  Run scripts in `dw/` to build fact tables.
3.  Run scripts in `reporting/` to generate the final performance report.
