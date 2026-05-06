# 🥛 Dairy Business Intelligence System — Amul

An end-to-end **Business Intelligence System** built during a **16-week Data Analyst Internship** — analysing real dairy operational data across milk collection, product sales, product costs, and spoilage losses to support data-driven management decisions.

---

## 🌟 Project Overview

This project builds a complete **Dairy BI System** that:
- Collects and cleans **4 operational datasets**
- Calculates key **business KPIs** (revenue, cost, profit, profit margin)
- Generates **data visualisations** for management reporting
- Executes **advanced SQL queries** for business insights
- Delivers an **interactive Excel dashboard** for non-technical stakeholders

All outputs were **cross-validated between Python and SQL** to confirm accuracy and consistency.

---

## 📊 Datasets Analysed

| Dataset | Key Fields |
|---------|-----------|
| **Milk Collections** | Collection ID, Supplier ID, Litres Collected, Fat %, SNF %, Temperature on Arrival, Quality Grade |
| **Product Sales** | Sale ID, Date, Region, Product Name, Units Sold, Price Per Unit, Revenue, Promotion Flag |
| **Product Costs** | Product Name, MRP, Base Production Cost, Packaging Cost, Logistics Cost, Storage Cost, Total Cost Per Unit |
| **Spoilage Loss Estimation** | Collection ID, Supplier ID, Spoilage Rate, Spoiled Litres, Loss Amount (₹) |

---

## ✨ Key Features

### 🐍 Python Analysis (Jupyter Notebook)
- Loaded and explored all 4 datasets using **Pandas**
- **Data Cleaning** — removed nulls, duplicate records, and inconsistent formats
- Calculated KPIs:
  - Total Revenue = Units Sold × Selling Price
  - Total Cost = Units Sold × Cost Per Unit
  - Net Profit = Total Revenue − Total Cost − Spoilage Loss
  - Profit Margin % = (Net Profit / Revenue) × 100
- Generated **Matplotlib visualisations**:
  - 📈 Monthly Revenue Trend
  - 🏆 Top 10 Products by Revenue
  - 🗺️ Region-wise Revenue Breakdown
  - 📦 Units Sold by Product
  - 🔵 Revenue vs Units Sold scatter
  - 🚨 Revenue Outlier Detection (Box Plot)
  - 📊 Revenue Distribution Histogram
  - 🥛 Average Fat % and SNF % by Supplier
  - 💸 KPI Summary Cards (Net Profit, Profit Margin, Revenue Per Litre)

### 🗄️ SQL Analysis (MySQL)
- Designed and created **5 relational tables** with primary keys and foreign key constraints
- **Data Cleaning via SQL** — duplicate detection, null checks, invalid value detection
- **Joins & Relationships** — sales with product costs, milk collections with spoilage data
- **Advanced Queries**:
  - Window Functions — `RANK()`, `DENSE_RANK()`, `LAG()`, `SUM() OVER()`
  - Running Total Revenue
  - 7-Day Moving Average of Sales
  - Month-over-Month Revenue Growth %
  - Seasonal Peak Detection
  - Outlier Milk Collection Detection (Mean + 2×STDDEV)
  - Supplier Performance Ranking
  - CTE: High Profit Sales (Profit > ₹1,000)
  - Product Contribution % to Total Revenue
- **Performance Optimisation** — composite indexes on `sales(product_name, date)`

### 📊 Excel Dashboard (MS Excel)
- **Structured Data Entry Forms** for all 4 datasets with validation
- **Pivot Tables** for Sales & Profit, and Milk Collection & Spoilage
- **Interactive Dashboard** with:
  - Sales vs Profit Overview
  - Milk Collection vs Spoilage Overview
  - Slicers for one-click filtering by product and time period
  - Macros for Refresh All, Reset Filters, and Navigate Sheets

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Python 3 | Data analysis, KPI calculation |
| Pandas | Data loading, cleaning, transformation |
| Matplotlib | Charts and visualisations |
| Jupyter Notebook | Interactive analysis environment |
| MySQL | Relational database, SQL queries |
| MySQL Workbench | Database design and query execution |
| Microsoft Excel (Advanced) | Dashboard, Pivot Tables, Macros, Forms |

---

## 📁 Project Structure

```
Dairy-BI-System/
│
├── Milk_Analysis.ipynb        # Complete Python analysis notebook
├── CREATE_TABLE.sql           # Database schema — all 5 tables
├── queries.sql                # All SQL queries (cleaning, joins, advanced, insights)
├── Main1.xlsm                 # Interactive Excel dashboard with macros
└── README.md
```

---

## 🚀 Getting Started

### Python Notebook
```bash
# Clone the repository
git clone https://github.com/dpatel3004/Dairy-BI-System.git
cd Dairy-BI-System

# Install dependencies
pip install pandas matplotlib openpyxl jupyter

# Launch notebook
jupyter notebook Milk_Analysis.ipynb
```

### SQL Setup
```sql
-- Run CREATE_TABLE.sql first to set up the database
-- Then run queries.sql for all analysis queries
SOURCE CREATE_TABLE.sql;
SOURCE queries.sql;
```

### Excel Dashboard
- Screenshots of Dashboard:
  
<img width="1201" height="683" alt="Image" src="https://github.com/user-attachments/assets/b8f9c7b7-9812-42da-9d77-3d3528502fd2" />
<img width="1398" height="683" alt="Image" src="https://github.com/user-attachments/assets/5ffa476c-18d9-4a1a-8c1d-f6315a0ef042" />
<img width="1398" height="683" alt="Image" src="https://github.com/user-attachments/assets/1035db3d-0f8d-4279-95d1-4a86ebd24d3e" />

---

## 📈 Business Insights Generated

- ✅ Identified **top 5 most profitable products** by net profit
- ✅ Detected **seasonal sales peaks** by month
- ✅ Calculated **revenue per litre** of milk collected
- ✅ Quantified **total financial impact of spoilage losses** in ₹
- ✅ Ranked **suppliers by milk volume and fat quality**
- ✅ Measured **month-over-month revenue growth %**
- ✅ Flagged **outlier milk collections** for quality review
- ✅ Identified **products with above-average sales performance**
- ✅ Calculated **product contribution %** to total revenue

---


## 👩‍💻 Developer

**Dhruvi Patel**
Computer Engineering Graduate · Frontend Developer · Data Analyst
📧 dhruvispatel30@gmail.com
🔗 [LinkedIn](https://linkedin.com/in/dhruvi-patel-b70a01254)

---

## 🏅 Related Certification

This project was completed alongside the **IBM Data Science Professional Certificate** (Coursera, April 2026) — covering Python, SQL, Data Analysis, Visualisation, and Machine Learning.
[Verify Certificate](https://coursera.org/verify/professional-cert/JT4Z7GVHITK1)
