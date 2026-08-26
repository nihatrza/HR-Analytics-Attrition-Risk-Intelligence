# 📊 Enterprise HR Analytics & Attrition Risk Intelligence System

📌 Executive Summary

This repository contains an end-to-end HR Data Analytics solution and executive dashboard designed to address employee retention, compensation disparities, and workforce turnover risks. The project cleans, transforms, and models workforce data for over 1,400 employees to uncover actionable business insights regarding voluntary attrition, work-life balance impact, and financial risk across departments.

By leveraging **Python** for Data Cleaning & EDA, **PostgreSQL** for Data Warehousing, and **Power BI** for advanced visualization and DAX modeling, this project serves as a comprehensive demonstration of full-stack Data Analytics and Data Engineering capabilities.

---

## 🔄 End-to-End Data Pipeline (ETL)

The project architecture strictly follows industry-standard ETL processes:

1. **Extraction & Transformation (Python & Pandas):**
   * Processed raw HR datasets using custom Jupyter Notebooks (`notebooks/hr_attrition_data_cleaning_eda.ipynb`).
   * Cleaned schema anomalies, missing values, and validated numerical distributions.
   * Derived synthetic features such as `AttritionRiskScore` and standardized numerical flags.
   * Exported structured tables formatted for relational star-schema deployment.

2. **Database Loading (PostgreSQL):**
   * Engineered DDL schemas (`sql/queries.sql`) to import data into a relational PostgreSQL database.
   * Established foreign key relationships across `job_id`, `demographics_id`, and `satisfaction_id`.
   * Performed multi-table SQL joins, CTEs, and Window Functions to extract strategic insights directly in pgAdmin 4.

3. **Analytics & Visualization (Power BI):**
   * Modeled a highly optimized Star Schema with a 1:N relationship from dimensions to the central fact table.
   * Authored dynamic DAX measures for retention tracking, overtime impact, and risk scoring.
   * Designed a SaaS-inspired 4-page UI/UX interface with normalized color semantics and seamless navigation.

---

## 📐 Database Schema & Data Modeling

The relational backend is organized into an optimized **Star Schema** architecture to maximize query performance and visual interactivity:

* **`fact_employee_attrition`** *(Fact)* — Stores transactional records, monthly income, overtime status, tenure, and attrition indicators.
* **`dim_job`** *(Dimension)* — Contains job hierarchy including `JobRole`, `Department`, and `JobLevel`.
* **`dim_demographics`** *(Dimension)* — Stores demographic indicators including `Gender`, `MaritalStatus`, `EducationField`, and `AgeGroup`.
* **`dim_satisfaction`** *(Dimension)* — Captures survey metrics including `EnvironmentSatisfaction`, `JobSatisfaction`, and `WorkLifeBalance`.

---

## 💡 Advanced SQL Analytics & Key Business Insights

Extensive exploratory data analysis was conducted using complex SQL queries (Window Functions, CTEs, Aggregations) inside PostgreSQL:

* **⏰ OverTime & Work-Life Balance Interaction:** Employees working OverTime with a low Work-Life Balance rating (1) exhibit a peak attrition rate of **45.45%**, compared to just **8.45%** for non-overtime staff with high work-life balance.
* **💸 Salary Disparity & Retention:** Window function analysis (`AVG OVER (PARTITION BY JobRole)`) proved that departing staff were paid significantly below their respective role averages (e.g., departing Managers earned **$3,500 – $5,300 less** than active peers).
* **💼 High-Cost Attrition Roles:** While *Laboratory Technicians* lead in volume (62 departures), *Sales Executives* represent the highest financial loss, draining **$426,873/month** in lost payroll budget due to turnover (57 departures at an average salary of $7,489).
* **🎓 Demographic Vulnerabilities:** Male employees with *Technical Degrees* and *Marketing* backgrounds display elevated attrition rates of **27.50%** and **22.22%**, respectively.

*(Note: The full suite of analytical queries used to generate these insights is available in `sql/queries.sql`)*

---

## 🎯 Strategic Recommendations for HR Leadership & Executives

1. **OverTime Cap & Work-Life Intervention:** Implement a mandatory review policy for employees logging consistent OverTime. Reducing burnout in low work-life balance groups can reduce overall company attrition by up to 30%.
2. **Targeted Salary Adjustments (Equity Audit):** Prioritize mid-year compensation reviews for employees performing below their `JobRole` average salary, specifically targeting *Sales Executives* and *Research Scientists* to prevent high-cost talent drain.
3. **Departmental Retention Focus (R&D & Sales):** Establish tailored retention programs for *Laboratory Technicians* and *Research Scientists*, focusing on career pathing, educational support, and promotion velocity.
4. **Proactive Intervention via Risk Detector:** Utilize the *Risk Detector Command Center* to identify active employees with high risk scores ($\ge 3$) and initiate proactive stay-interviews before formal resignation notices occur.

---

## 📊 Dashboard Architecture & Interactive Navigation

The Power BI dashboard utilizes a modern, 4-page application UI/UX layout with dedicated executive views:

1. **Executive Overview (Macro Analytics):** High-level executive KPIs, department-level attrition counts, job level breakdowns, and income distribution.
2. **Demographics:** Turnover distribution across age cohorts, marital status, gender, and commuting distance.
3. **Satisfaction & Pay Drivers:** Multi-dimensional analysis using Scatter Plots to evaluate monthly income vs. attrition rate alongside work-life balance ratings.
4. **Risk Detector (Command Center):** AI-powered Key Influencers combined with an active high-risk employee roster for proactive HR management.

---

## 📂 Repository Structure

```text
HR-Analytics-Attrition-Risk-Intelligence/
│
├── assets/                          # Dashboard screenshots and visual documentation
│   ├── page1_overview.png
│   ├── page2_demographics.png
│   ├── page3_satisfaction.png
│   └── page4_risk_detector.png
│
├── notebooks/                       # Data Processing & EDA
│   └── hr_attrition_data_cleaning_eda.ipynb
│
├── sql/                             # PostgreSQL Backend
│   └── queries.sql                  # Analytical queries (CTEs, Window Functions, Joins)
│
├── reports/                         # Power BI Frontend
│   └── HR_Analytics.pbix            # Interactive Power BI Desktop file
│
├── .gitignore
├── LICENSE
└── README.md                        # Project documentation
