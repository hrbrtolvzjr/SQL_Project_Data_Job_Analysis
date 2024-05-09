/*
Question: What are the top_paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in the Philippines.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the the top-paying oppurtunities for Data Analysts, offering insights into employment.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_country,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Philippines' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

