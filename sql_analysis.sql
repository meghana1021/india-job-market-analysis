CREATE DATABASE job_market_db;
USE job_market_db;
CREATE TABLE india__job_market (
    Job_Title            TEXT,
    Location             TEXT,
    Locality             TEXT,
    State                TEXT,
    Work_Mode            TEXT,
    Job_Category         TEXT,
    Salary               TEXT,
    Salary_Type          TEXT,
    Monthly_Salary_INR   TEXT
);
SELECT COUNT(*) AS total_records
FROM india__job_market;

DROP TABLE IF EXISTS india__job_market;





SELECT 
    COUNT(*) AS total_listings,
    COUNT(DISTINCT State) AS total_states,
    COUNT(DISTINCT Job_Category) AS total_categories,
    COUNT(DISTINCT Locality) AS total_cities
FROM india__job_market;




SELECT 
    State,
    COUNT(*) AS total_jobs,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM india__job_market), 2) AS percentage
FROM india__job_market
GROUP BY State
ORDER BY total_jobs DESC
LIMIT 10;





SELECT
    Job_Category,
    COUNT(*) AS total_jobs,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM india__job_market), 2) AS market_share_pct
FROM india__job_market
GROUP BY Job_Category
ORDER BY total_jobs DESC;




SELECT
    Work_Mode,
    COUNT(*) AS total_jobs,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM india__job_market), 2) AS percentage
FROM india__job_market
GROUP BY Work_Mode
ORDER BY total_jobs DESC;

DESCRIBE india__job_market;
ALTER TABLE india__job_market 
RENAME COLUMN `ï»¿Job_Title` TO `Job_Title`;


SELECT
    Job_Category,
    COUNT(*) AS total_jobs,
    ROUND(AVG(Monthly_Salary_INR), 0) AS avg_monthly_salary,
    ROUND(MIN(Monthly_Salary_INR), 0) AS min_salary,
    ROUND(MAX(Monthly_Salary_INR), 0) AS max_salary
FROM india__job_market
WHERE Monthly_Salary_INR IS NOT NULL
GROUP BY Job_Category
ORDER BY avg_monthly_salary DESC;




SELECT 
    Job_Title,
    Job_Category,
    State,
    Work_Mode,
    ROUND(Monthly_Salary_INR, 0) AS monthly_salary_inr
FROM india__job_market
WHERE Monthly_Salary_INR IS NOT NULL
ORDER BY Monthly_Salary_INR DESC
LIMIT 10;




SELECT
    Work_Mode,
    COUNT(*) AS total_jobs,
    ROUND(AVG(Monthly_Salary_INR), 0) AS avg_monthly_salary,
    ROUND(MAX(Monthly_Salary_INR), 0) AS max_salary,
    ROUND(MIN(Monthly_Salary_INR), 0) AS min_salary
FROM india__job_market
WHERE Monthly_Salary_INR IS NOT NULL
GROUP BY Work_Mode
ORDER BY avg_monthly_salary DESC;




SELECT 
    Locality AS city,
    State,
    COUNT(*) AS total_jobs
FROM india__job_market
WHERE Locality != 'Remote'
GROUP BY Locality, State
ORDER BY total_jobs DESC
LIMIT 10;




SELECT
    Job_Category,
    COUNT(*) AS total_jobs,
    COUNT(Monthly_Salary_INR) AS jobs_with_salary,
    COUNT(*) - COUNT(Monthly_Salary_INR) AS jobs_without_salary,
    ROUND(
        COUNT(Monthly_Salary_INR) * 100.0 / COUNT(*), 1
    )  AS salary_disclosure_pct
FROM india__job_market
GROUP BY Job_Category
ORDER BY salary_disclosure_pct DESC;






SELECT 
    State,
    COUNT(*) AS total_jobs,
    COUNT(Monthly_Salary_INR) AS jobs_with_salary,
    ROUND(AVG(Monthly_Salary_INR), 0) AS avg_monthly_salary,
    ROUND(MAX(Monthly_Salary_INR), 0) AS highest_salary
FROM india__job_market
WHERE Monthly_Salary_INR IS NOT NULL
  AND State != 'Remote'
GROUP BY State
HAVING COUNT(*) >= 5
ORDER BY avg_monthly_salary DESC
LIMIT 10;
