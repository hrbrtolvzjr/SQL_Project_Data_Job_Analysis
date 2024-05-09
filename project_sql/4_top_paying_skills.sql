/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skills for Data Analyst positions.
- Focuses on roles with specidied salaries, in the Philippines.
- Why? It reveals how different skills impact salary levels for Data Analysts anfd
    helps identify the most finanacially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND (AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Philippines' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills,
    job_country,
    salary_year_avg
ORDER BY    
    avg_salary DESC
LIMIT 25

/*
Here's a breakdown of the results for top paying skills for Data Analysts in the Philippines
- Proficiency in programming languages like Python, R, and SQL remains highly valued, with average salaries of $111,175.
- Tools such as Jira, Looker, Flow, Zoom, Snowflake, and BigQuery indicate a growing emphasis on project management, data visualization, workflow automation, and cloud-based analytics platforms.
- Excel's enduring relevance, alongside the importance of general office software skills like SharePoint, Word, and PowerPoint, underscores the need for a diverse skill set encompassing technical prowess and effective communication abilities.

[
  {
    "skills": "jira",
    "avg_salary": "111175"
  },
  {
    "skills": "looker",
    "avg_salary": "111175"
  },
  {
    "skills": "flow",
    "avg_salary": "111175"
  },
  {
    "skills": "c",
    "avg_salary": "111175"
  },
  {
    "skills": "python",
    "avg_salary": "111175"
  },
  {
    "skills": "sql",
    "avg_salary": "111175"
  },
  {
    "skills": "r",
    "avg_salary": "111175"
  },
  {
    "skills": "zoom",
    "avg_salary": "111175"
  },
  {
    "skills": "snowflake",
    "avg_salary": "111175"
  },
  {
    "skills": "bigquery",
    "avg_salary": "111175"
  },
  {
    "skills": "sheets",
    "avg_salary": "111175"
  },
  {
    "skills": "excel",
    "avg_salary": "111175"
  },
  {
    "skills": "tableau",
    "avg_salary": "111175"
  },
  {
    "skills": "sharepoint",
    "avg_salary": "109500"
  },
  {
    "skills": "excel",
    "avg_salary": "109500"
  },
  {
    "skills": "word",
    "avg_salary": "100500"
  },
  {
    "skills": "sql",
    "avg_salary": "100500"
  },
  {
    "skills": "power bi",
    "avg_salary": "100500"
  },
  {
    "skills": "qlik",
    "avg_salary": "100500"
  },
  {
    "skills": "tableau",
    "avg_salary": "100500"
  },
  {
    "skills": "python",
    "avg_salary": "100500"
  },
  {
    "skills": "r",
    "avg_salary": "100500"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "100500"
  },
  {
    "skills": "excel",
    "avg_salary": "100500"
  },
  {
    "skills": "snowflake",
    "avg_salary": "98500"
  }
]

*/