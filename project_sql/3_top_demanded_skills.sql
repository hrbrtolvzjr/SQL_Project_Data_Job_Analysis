/*
Question: What are the most in-demand skills for data analysts in the Philippines?
- Join job postings to inner join table similar to query 2?
- Identifyt the top 5 in-demand skills for a data analyst.
- Focous on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    job_country AS country
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True AND
    job_country = 'Philippines'
GROUP BY
    skills,
    job_country
ORDER BY    
    demand_count DESC
LIMIT 5

/*
Here's the breakdown of the most demand skills for data analyst in 2023 Philippines
SQL and Excel remain fundamental, emphasizing the need for strong foundation in
Programming and Visualization Tools like Python, Tableau, and Power BI

[
  {
    "skills": "excel",
    "demand_count": "300",
    "country": "Philippines"
  },
  {
    "skills": "sql",
    "demand_count": "244",
    "country": "Philippines"
  },
  {
    "skills": "tableau",
    "demand_count": "150",
    "country": "Philippines"
  },
  {
    "skills": "python",
    "demand_count": "139",
    "country": "Philippines"
  },
  {
    "skills": "power bi",
    "demand_count": "108",
    "country": "Philippines"
  }
]

*/