# Safaricom Ethiopia: Revenue & Network Usage BI Pipeline

![Safaricom Logo](https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Safaricom_logo.svg/1200px-Safaricom_logo.svg.png)

## 📌 Project Overview
This project demonstrates a full-scale Business Intelligence (BI) lifecycle designed for **Safaricom Ethiopia**. The goal is to provide executive-level insights into airtime revenue, data consumption (4G/5G), and regional subscriber growth by integrating data from a legacy Oracle Billing system into a modern SQL Server Data Warehouse.

### 🏗️ Architecture Flow
**Oracle DB (Source)** ➡️ **SSIS (ETL)** ➡️ **MS SQL Server (DWH)** ➡️ **Power BI (Visualization)**

---

## 📊 Power BI Dashboard
> **Note:** Below is a placeholder for the project dashboard. To display your actual report, you can either embed a screenshot or a link to the Power BI Service.

### Executive Revenue Summary
![Safaricom Dashboard Screenshot](https://via.placeholder.com/800x450.png?text=Place+Your+Power+BI+Screenshot+Here)

*If you have published your report to the web, you can [View the Interactive Dashboard Here](https://your-link-to-powerbi-service.com).*

---

## 🛠️ Tech Stack & Components

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Source DB** | Oracle 19c | Production Billing & CDR (Call Detail Records) |
| **ETL Tool** | SSIS 2022 | Extraction, Data Type Mapping, and Fact Loading |
| **Warehouse** | MS SQL Server | Optimized Star Schema for analytical querying |
| **Visualization** | Power BI | Interactive Dashboards & DAX Reporting |

---

## 🚀 Step-by-Step Implementation

### 1. Data Warehouse Development (SQL Server)
The warehouse is built on a **Star Schema** to optimize query performance for millions of rows.
* **Dimensions:** `DimSubscriber` (SCD Type 1), `DimDate` (Includes Ethiopian Calendar), `DimRegion`.
* **Facts:** `FactRevenueUsage` (Granularity: Daily per Subscriber).
* *Refer to `/Scripts/DWH_Schema.sql` for the full DDL.*

### 2. ETL Process (SSIS)
The ETL logic handles the data movement and ensures data integrity:
1. **Extract:** Pulls raw transaction logs from Oracle using an OLE DB Source.
2. **Transform:** - **Data Conversion:** Converts Oracle `VARCHAR2` to SQL `NVARCHAR`.
   - **Lookup:** Validates subscriber IDs against the `DimSubscriber` table.
   - **Derived Column:** Calculates Net Revenue after 15% VAT deduction.
3. **Load:** Performs a "Fast Load" into the SQL Server Destination.

### 3. Power BI Modeling
* **Data Connectivity:** SQL Server Import Mode.
* **Modeling:** 1:N Relationships between Dimensions and Fact tables.
* **DAX Measures:**
  ```dax
  Total Revenue (ETB) = SUM(FactRevenueUsage[Revenue])
  Data Usage (TB) = SUM(FactRevenueUsage[DataMB]) / 1024 / 1024
  YoY Revenue Growth = VAR PrevYear = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR('DimDate'[FullDate])) RETURN DIVIDE([Total Revenue] - PrevYear, PrevYear)