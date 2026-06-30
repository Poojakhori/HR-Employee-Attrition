End-to-end SQL analysis of IBM's HR Employee Attrition dataset (1,470 employees, 35 attributes) — built to identify who is leaving, why, and who's likely to leave next, using MySQL.

📌 Business Problem

A company's HR team wants to understand its attrition patterns to:


Quantify the scale of the problem (overall + by department/role)
Identify the strongest drivers of attrition (pay, overtime, tenure, promotions, travel)
Flag currently employed people who match the profile of past leavers, for proactive retention


🗂️ Repo Structure

hr-attrition-sql/
├── data/
│   └── employees_clean.csv        # source data, column names normalized to snake_case
├── sql/
│   ├── 01_schema.sql               # CREATE DATABASE + TABLE + indexes
│   ├── 02_load_data.sql            # LOAD DATA INFILE script
│   └── 03_analysis_queries.sql     # 15 business-question queries, basic → advanced
└── README.md

🧰 SQL Techniques Demonstrated

TechniqueWhere usedAggregation (GROUP BY, HAVING)Q1–Q7, Q15CASE bucketing/segmentationQ6, Q7, Q11, Q13SubqueriesQ3, Q12Window functions (RANK, NTILE, AVG() OVER, running SUM() OVER)Q8, Q9, Q10, Q14CTEs (incl. multi-CTE risk scoring)Q10, Q11, Q12, Q14Multi-factor scoring logicQ12

📊 Key Findings (validated query outputs)

1. Overall attrition rate: 16.1% (237 of 1,470 employees)

2. Department risk: Sales (20.6%) and HR (19.1%) lose people far faster than R&D (13.8%)

3. Highest-risk roles: Sales Representatives top the list at 39.8% attrition — more than double the company average — followed by Lab Technicians (23.9%) and HR (23.1%)

4. Pay matters — a lot: Employees who left earned noticeably less than those who stayed in every department (e.g., R&D: $4,108 avg for leavers vs. $6,630 for stayers — a 38% gap)

5. Overtime is one of the single biggest predictors: Employees working overtime attrite at 30.5% vs. 10.4% for those who don't — nearly 3x higher

6. Under-25s are the flight-risk group: 39.2% attrition vs. 10–16% for every other age band

7. Attrition is front-loaded: 34.9% of employees leave within their first year; this drops to 8.1% for employees with 10+ years tenure — most churn happens early

8. Lowest salary quartile = 29.4% attrition vs. ~10% for the top two quartiles — a near 3x gap, confirming pay is one of the strongest single drivers

9. Manager relationship matters: Employees with <1 year under their current manager attrite at 28.3%, dropping to 10.9% after 7+ years with the same manager — manager churn/instability correlates with employee churn

10. Frequent travelers leave nearly 3x more than non-travelers (24.9% vs 8.0%)

11. Flight-risk model (Q12): a simple 5-factor risk score (overtime + low job/environment satisfaction + below-average pay + ≤2 yrs tenure) surfaces a ranked list of currently active employees who most resemble past leavers — directly actionable for HR retention outreach

💡 Recommendations (the "so what")

Prioritize retention conversations with early-tenure (<1yr), overtime-heavy, below-median-pay employees — this segment is the highest-leverage target
Review Sales Representative compensation and workload — attrition there is structurally different from the rest of the company
Re-examine frequent travel policies/compensation, especially combined with the above factors


🔧 Tools used
    MySQL
    Power BI
    SQL
    Excel

