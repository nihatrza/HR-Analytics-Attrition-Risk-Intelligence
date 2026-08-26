# 📊 Enterprise HR Analytics & Attrition Risk Intelligence System

An end-to-end HR Analytics solution designed to identify key drivers of employee turnover, analyze salary dynamics, and dynamically predict high-risk talent using Python, PostgreSQL, and Power BI.

---

## 🎨 Interactive Dashboard Preview

The Power BI solution consists of a 4-page SaaS-inspired interactive layout with unified visual hierarchy and color semantics:

1. **Executive Overview:** High-level retention KPIs, department-level attrition counts, and income distribution.
2. **Demographics:** Turnover distribution across age cohorts, marital status, gender, and commuting distance.
3. **Satisfaction & Pay Drivers:** Correlation analysis between salary, work-life balance, overtime status, and attrition via Scatter Plots.
4. **Risk Detector (Command Center):** AI-driven Key Influencers coupled with an active high-risk employee roster for proactive HR management.

---

## 🛠️ Tech Stack & Architecture

* **Data Cleaning & EDA:** Python (Pandas, NumPy) within Jupyter Notebooks (`notebooks/`)
* **Database & SQL:** PostgreSQL (pgAdmin 4) for relational analytics and complex querying (`sql/`)
* **Data Modeling:** Star Schema architecture (1 Fact Table, 3 Dimension Tables)
* **BI & Analytics:** Microsoft Power BI Desktop, Advanced DAX Measures
* **UI/UX Design:** Custom Application Sidebar Navigation, Color Semantics (Green/Red accent indicators)

---

## 📐 Database Architecture (Star Schema)

The dataset is transformed into a highly optimized Star Schema:
* **`fact_employee_attrition`** (Fact) — Core transactional metrics and employee records.
* **`dim_job`** (Dimension) — Job roles, job levels, and departments (`job_id`).
* **`dim_demographics`** (Dimension) — Gender, marital status, education field, and age groups (`demographics_id`).
* **`dim_satisfaction`** (Dimension) — Environment satisfaction, work-life balance ratings, and job involvement (`satisfaction_id`).

---

## 💡 Key Business Insights

* **OverTime Impact:** Employees working OverTime exhibit an attrition rate of **30.5%**, compared to **10.4%** for non-overtime staff.
* **Work-Life Balance Risk:** Staff working OverTime with a Work-Life Balance rating of 1 show a peak attrition rate of **45.45%**.
* **Salary Disparity:** Attrition is heavily concentrated among roles with a monthly income under **$5,000**.
* **Financial Risk:** The *Sales Executive* role alone accounts for **$426,873/month** in lost payroll budget due to turnover.

---

## 📁 Repository Structure

```text
├── assets/         # Dashboard screenshots and visual assets
├── notebooks/      # Jupyter Notebooks for Data Cleaning & EDA (.ipynb)
├── sql/            # PostgreSQL analytics queries (CTEs, Window Functions, Joins)
├── reports/        # Power BI Desktop File (.pbix)
├── .gitignore
├── LICENSE
└── README.md       # Project documentation
