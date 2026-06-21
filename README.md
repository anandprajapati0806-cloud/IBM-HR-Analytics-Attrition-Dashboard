# IBM HR Analytics — Employee Attrition Dashboard

An end-to-end HR Analytics project analyzing employee attrition at IBM, built using **PostgreSQL** for data cleaning and analysis, and **Power BI** for an interactive 5-page dashboard.

---

## 📌 Problem Statement

IBM is experiencing a significant employee attrition challenge — **16.12% of employees leave annually**, above the healthy industry benchmark of 10-12%. This project analyzes the IBM HR Analytics dataset to identify the key drivers of attrition (salary, overtime, work-life balance, job satisfaction, and demographics) and provides data-driven recommendations to improve retention.

---

## 🎯 What This Project Covers

- Cleaning and exploring 1,470 employee records using SQL
- Writing 13+ analytical queries to uncover attrition patterns
- Performing multi-factor analysis to find combined risk factors
- Building a 5-page interactive Power BI dashboard with DAX measures
- Translating findings into actionable business recommendations

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL (pgAdmin) | Data cleaning, SQL queries, exploratory analysis |
| Power BI Desktop | Data modeling, DAX measures, dashboard design |
| Power Query | Custom columns (age groups, income bands, attrition flags) |

---

## 🔍 Key Findings

| Finding | Insight |
|---|---|
| Overall Attrition Rate | **16.12%** — above industry benchmark |
| Highest Risk Combination | Age 18-25 + Overtime + Low Income → **73% attrition** |
| Highest Risk Job Role | Sales Representatives → **39% attrition** |
| Overtime Impact | Triples attrition in R&D (8.55% → 27.31%) |
| Promotion Paradox | Recently promoted employees show the *highest* attrition — likely due to title changes without matching salary increases |
| Department Risk | Sales has the highest department-level attrition at 20.63% |

---

## 📊 Dashboard Structure

The Power BI dashboard is split across 5 pages, each answering a different question:

1. **Executive Summary** — Headline KPIs, department/gender/age breakdowns
2. **Attrition Analysis** — Deep dive into overtime, income, tenure, and promotion gap
3. **Employee Demographics** — Workforce composition (gender, education, marital status, job roles)
4. **Job Satisfaction & Performance** — How satisfaction and training connect to attrition
5. **Recommendations** — Data-backed action plan with projected business impact

---

## 💡 Recommendations

1. **Salary Revision** — Increase pay for employees earning under $3,000/month
2. **Overtime Policy** — Cap overtime at 2 days/week
3. **Young Employee Retention Program** — Mentorship and clear career growth paths for ages 18-25
4. **Sales Department Intervention** — Review commission structure, reduce travel demands, add mental health support

**Projected Impact:** Reducing attrition from 16.12% to 10% could save IBM an estimated **$2-4 million annually** in employee replacement costs.

---

## 📁 Repository Structure

├── Data/
│   ├── hr_analytics_raw.csv        # Original dataset
│   └── hr_analytics_clean.csv      # Cleaned dataset used for analysis
├── SQL/
│   └── IBM_HR_SQL_Analysis.sql     # 13+ queries with findings as comments
├── PowerBI/
│   └── IBM_HR_Dashboard.pbix       # Full interactive dashboard
├── Visuals/
│   └── (Dashboard page screenshots — all 5 pages)
├── Report/
│   └── IBM_HR_Data_Understanding   # Data dictionary and project notes
└── README.md

---

## 🚀 How to Explore This Project

- **View the dashboard:** Download `PowerBI/IBM_HR_Dashboard.pbix` and open in Power BI Desktop (free)
- **Review the analysis:** Open `SQL/IBM_HR_SQL_Analysis.sql` to see the full query logic and findings
- **Quick preview:** Check the `Visuals/` folder for dashboard screenshots without downloading anything

---

## 👤 About This Project

This was built as a self-directed portfolio project to practice the complete Data Analyst workflow — from raw data to business recommendations — using tools commonly required for entry-level Data Analyst roles.
