-- Phase1 Database setup
Create Database if not exists HR_Analytics;
Use HR_Analytics;
Create table HR_Employee;
-- View data
Select * from hr_Employee;
-- Describe Table
desc HR_Employee;

-- Phase 2: Data Cleaning
-- Find Null value
Select * from HR_Employee
where Monthlyincome is NULL;

-- Alter column name 
Alter Table HR_Employee
Rename Column ï»¿Age to Age;

-- Count Null
Select
Sum(Case when Age is Null then 1 else 0 End) Age,
Sum(Case when Department is Null t
en 1 else 0 End) Department,
Sum(Case when Monthlyincome is Nul l then 1 else 0 End) Income
from HR_Employee;

-- Find Duplicates
Select Employeenumber, count(*) from HR_Employee
group by Employeenumber
Having Count(*)>1;

-- Distinct Department
Select distinct Department from HR_Employee;

-- Distinct Job Roles
Select distinct Jobrole from HR_Employee;

-- Phase 3 — Exploratory Data Analysis
-- Employee count
Select Count(*) from HR_Employee;

-- Youngest,Oldest & Average age of Employees
Select Min(Age), Max(Age), Avg(Age)from HR_Employee;

-- Highest, Lowest & Average salary of Employees
Select Max(MonthlyIncome), Min(MonthlyIncome), Round(Avg(MonthlyIncome), 2) from HR_Employee;

-- Employee by Education
Select Education, count(*) Employees from HR_Employee
Group by Education;

-- Employees by Gender
Select Gender, count(*) Employees from HR_Employee
Group by Gender;

-- Employees by Department
Select Department, count(*) Employees from HR_Employee
Group by Department;

-- Employees by Jobrole
Select Jobrole, count(*) Employees from HR_Employee
Group by Jobrole;

-- Employees by Marital Status
Select MaritalStatus, count(*) Employees from HR_Employee
Group by MaritalStatus;

-- Employees by Business Travel
Select BusinessTravel, count(*) Employees from HR_Employee
Group by BusinessTravel;

-- Employees working overtime
Select Overtime, count(*) Employees from HR_Employee
Group by Overtime;

-- Number of Employess left
Select Count(*) as Employessleft from HR_Employee
where Attrition ="yes";

-- Number of Active employee
Select Count(*) as ActiveEmployee from HR_Employee
where Attrition ="no";

-- Phase 4 KPI Analysis
-- Overall Attrition Rate
Select
Round(Sum(Case When Attrition="Yes" then 1 else 0 END)*100/COUNT(*),2) as Overall_Attrition_Rate
from HR_Employee;

-- Attriton by Department
SELECT
    department,
    COUNT(*)                                            AS headcount,
    SUM(attrition = 'Yes')                              AS attrited,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM HR_Employee
GROUP BY department
ORDER BY attrition_rate_pct DESC;

-- Attrition by Gender
Select
Gender, 
count(*) as headcount,
Sum(Attrition="Yes"),
Round(sum(Attrition="Yes")*100/count(*),2) as Attritionrate
FROM HR_Employee
group by Gender
Order by Attritionrate;

-- Attrition by Age
Select 
Case When Age< 30 then '20-29'
	 When Age between 30 and 39 then '30-39'
     When Age between 40 and 49 then '40-49'
Else '50+' END Age_Group,
Count(*) as TotalEmployees,
Sum(Case When Attrition ="Yes" then 1 else 0 END) AS Employeeleft,
Round(Sum(Case When Attrition="Yes" then 1 else 0 end)*100/count(*),2) as Attritionrate
from HR_Employee
group by Age_Group
order by Age_Group;

-- Attrition by Salary Band
Select 
Case When Monthlyincome < 5000 then 'Low'
	 When Monthlyincome between 5000 and 10000 then 'Medium'
Else 'High' END as Salary_Band,
Count(*) as TotalEmployees,
Sum(Case When Attrition ="Yes" then 1 else 0 END) AS Employeeleft,
Round(Sum(Case When Attrition="Yes" then 1 else 0 end)*100/count(*),2) as Attritionrate
from HR_Employee
group by Salary_Band;

-- Attrition by Marital Status
Select 
MaritalStatus, 
Count(*) as TotalEmployees, 
Sum(Case When Attrition ="Yes" then 1 else 0 END) AS Employeeleft
from HR_Employee
group by MaritalStatus;

-- Attrition by Business Travel
Select 
BusinessTravel, 
Count(*) as TotalEmployees, 
Sum(Case When Attrition ="Yes" then 1 else 0 END) AS Employeeleft,
Round(Sum(Case When Attrition="Yes" then 1 else 0 end)*100/count(*),2) as Attritionrate
from HR_Employee
group by BusinessTravel; 

-- Top 5 job roles by attrition rate (min 20 headcount)
SELECT
    jobrole,
    COUNT(*)                                            AS headcount,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM HR_Employee
GROUP BY jobrole
HAVING COUNT(*) >= 20
ORDER BY attrition_rate_pct DESC
LIMIT 5;

-- Income comparison: stayed vs left, by department
SELECT
    department,
    COUNT(*)                      AS headcount
FROM HR_Employee
GROUP BY department, attrition
ORDER BY department, attrition;

-- Overtime vs attrition
SELECT
    overtime,
    COUNT(*)                                            AS headcount,
    SUM(attrition = 'Yes')                              AS attrited,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM HR_employee
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;
-- Phase 5 — Business Analysis
-- Average Salary of Employees Who Left
Select Attrition, Round(Avg(MonthlyIncome),0) from HR_Employee
group by Attrition;

-- Average Years at Company
Select Attrition, Round(Avg(YearsAtCompany),0) from HR_Employee
group by Attrition;

-- Average Distance from Home
Select Attrition, Round(Avg(DistanceFromHome),0) from HR_Employee
group by Attrition;

-- Monthly Income by Department
Select Department, Round(Avg(Monthlyincome),0) from HR_Employee
group by Department;

-- Tenure buckets vs attrition
Select 
Case when YearsAtCompany<= 1 then '0-1'
	 when YearsAtCompany<= 3 then '2-3'
	 when YearsAtCompany<= 5 then '4-5'
	 when YearsAtCompany<= 10 then '6-10'
Else '10+' End as Years,
Count(*) as Headcount,
Round(sum(Attrition='yes')*100/count(*),2) as Attritiionrate
from HR_Employee
Group by years
Order by (Min(yearsatcompany));

-- Highest & Lowest Paying Departments
SELECT 
    Department,
    ROUND(MAX(Monthlyincome), 0),
    ROUND(MIN(Monthlyincome), 0)
FROM
    HR_Employee
GROUP BY Department;

-- Phase 6 — Advanced SQL
-- Window Function|| Top 5 Highest Paid
Select * from (Select
Employeenumber, 
Monthlyincome, 
Dense_rank()
over(order by Monthlyincome Desc) as 
    attrition,
    ROUND(AVG(monthlyincome), 0) AS avg_monthly_income,Salaryrank
From HR_Employee
) AS Ranked
Where Salaryrank <= 5;

-- Rank, Denserank & Rownumber Employees by Experience
Select * from (Select
Employeenumber, 
YearsAtCompany, 
rank()
over(order by YearsAtCompany Desc) as Rnk,
dense_rank()
over(order by YearsAtCompany Desc) as denseRnk,
row_number()
over(order by YearsAtCompany Desc) as rownumber
From HR_Employee
) AS Ranked

-- Running total
Select 
EmployeeNumber, MonthlyIncome, Sum(MonthlyIncome)
over(
order by Employeenumber)
from HR_Employee;
 
 -- Department Average Salary
 Select 
EmployeeNumber, Department, MonthlyIncome, avg (MonthlyIncome)
over(
partition by Department)
from HR_Employee;

-- Salary Difference from Department Average
 Select 
EmployeeNumber, Department, MonthlyIncome, MonthlyIncome- avg (MonthlyIncome)
over( 
partition by Department) as Difference
from HR_Employee;

-- Gender pay gap within each job role
SELECT DISTINCT
    jobrole,
    gender,
    ROUND(AVG(monthlyincome) OVER (PARTITION BY jobrole, gender), 0)  AS avg_income_by_gender,
    ROUND(AVG(monthlyincome) OVER (PARTITION BY jobrole), 0)         AS avg_income_role_overall
FROM HR_employee
ORDER BY jobrole, gender;
Use HR_Analytics;
-- WINDOW FUNCTION: Salary quartile (NTILE) vs attrition
	WITH salary_quartiles AS (
		SELECT
			employeenumber,
			monthlyincome,
			attrition,
			NTILE(4) OVER (ORDER BY monthlyincome) AS income_quartile
		FROM hr_employee
)
SELECT
    income_quartile,
    COUNT(*)                                             AS headcount,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2)  AS attrition_rate_pct
FROM salary_quartiles
GROUP BY income_quartile
ORDER BY income_quartile;
-- Years since last promotion vs attrition
WITH promotionbuckets AS (
    SELECT
        attrition,
        CASE
            WHEN yearssincelastpromotion = 0 THEN 'Promoted this year'
            WHEN yearssincelastpromotion <= 2 THEN '1-2 yrs ago'
            WHEN yearssincelastpromotion <= 5 THEN '3-5 yrs ago'
            ELSE '5+ yrs ago'
        END AS promotionbucket
    FROM hr_employee
)
SELECT
    promotionbucket,
    COUNT(*)                                            AS headcount,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM promotionbuckets
GROUP BY promotionbucket
ORDER BY attrition_rate_pct DESC;

-- multi-factor flight-risk scoring (Combines overtime, low satisfaction, low income quartile, low tenure)
WITH scored AS (
    SELECT
        employeenumber,
        jobrole,
        department,
        monthlyincome,
        jobsatisfaction,
        overtime,
        yearsatcompany,
        attrition,
        (CASE WHEN overtime = 'Yes' THEN 1 ELSE 0 END
       + CASE WHEN jobsatisfaction <= 2 THEN 1 ELSE 0 END
       + CASE WHEN environmentsatisfaction <= 2 THEN 1 ELSE 0 END
       + CASE WHEN monthlyincome < (SELECT AVG(monthlyincome) FROM HR_employee) THEN 1 ELSE 0 END
       + CASE WHEN yearsatcompany <= 2 THEN 1 ELSE 0 END
        ) AS risk_score
    FROM HR_employee
)
SELECT
    employeenumber, jobrole, department, monthlyincome,
    jobsatisfaction, overtime, yearsatcompany, risk_score
FROM scored
WHERE attrition = 'No'                -- still employed
ORDER BY risk_score DESC, monthlyincome ASC
LIMIT 15;

SELECT
    CASE
        WHEN yearswithcurrmanager <= 1 THEN '0-1 yrs'
        WHEN yearswithcurrmanager <= 3 THEN '2-3 yrs'
        WHEN yearswithcurrmanager <= 6 THEN '4-6 yrs'
        ELSE '7+ yrs'
    END                                                  AS manager_tenure_band,
    COUNT(*)                                             AS headcount,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2)  AS attrition_rate_pct
FROM HR_employee
GROUP BY manager_tenure_band
ORDER BY MIN(yearswithcurrmanager);

-- Running cumulative attrition count by years at company
-- (Demonstrates a cumulative/running window function)
WITH yearly AS (
    SELECT
        yearsatcompany,
        SUM(attrition = 'Yes') AS attritions_this_year
    FROM HR_employee
    GROUP BY yearsatcompany
)
SELECT
    yearsatcompany,
    attritions_this_year,
    SUM(attritions_this_year) OVER (ORDER BY yearsatcompany) AS cumulative_attritions
FROM yearly
ORDER BY yearsatcompany;

-- Business travel frequency vs attrition
SELECT
    businesstravel,
    COUNT(*)                                            AS headcount,
    ROUND(SUM(attrition = 'Yes') * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM HR_employee
GROUP BY businesstravel
ORDER BY attrition_rate_pct DESC;

