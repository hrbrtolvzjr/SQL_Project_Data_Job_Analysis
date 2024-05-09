/*
Answer: What are the most optimal skills to leaarn (aka it's in high demand and a high-paying skills)?
- Identify skills in demand and associated with high average salaries for Data Analyst roles in the Philippines.
- Concentrates on remote posistions with specified salaries
- Why? Target skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic ingishgtss for career development in data analysis
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        job_country AS country
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Philippines'
    GROUP BY
        skills_dim.skill_id,
        job_country
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        job_country AS country,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Philippines'
    GROUP BY
        skills_job_dim.skill_id,
        job_country
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary,
    skills_demand.country
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.country = 'Philippines'
ORDER BY
    avg_salary DESC, 
    demand_count DESC
LIMIT 25

/*
Here's a breakdown of the most optimal skills for Data Analysts in the Philippines:

Key Programming Languages:
- Proficiency in programming languages like Python and R, 
along with SQL expertise, continues to be highly valued. Professionals adept in these languages command an average salary of $111,175, reflecting the essential role they play in data analysis and manipulation.
- Tools for Enhanced Efficiency:
- Emerging tools such as Jira, Looker, Flow, Zoom, Snowflake, and BigQuery 
are gaining prominence, indicating a growing emphasis on project management, data visualization, workflow automation, and cloud-based analytics platforms. Mastery of these tools not only streamlines processes but also enhances productivity and decision-making capabilities within organizations.
- Enduring Relevance of Office Software Skills:
Despite the technological advancements, 
the enduring relevance of Microsoft Excel persists. Alongside Excel, proficiency in general office software skills like SharePoint, Word, and PowerPoint remains crucial. This underscores the need for a diverse skill set encompassing technical prowess and effective communication abilities. Professionals adept in these tools contribute significantly to data-driven decision-making processes while facilitating seamless collaboration and communication within teams.

[
  {
    "skill_id": 192,
    "skills": "sheets",
    "demand_count": "1",
    "avg_salary": "111175",
    "country": "Philippines"
  },
  {
    "skill_id": 248,
    "skills": "zoom",
    "demand_count": "1",
    "avg_salary": "111175",
    "country": "Philippines"
  },
  {
    "skill_id": 26,
    "skills": "c",
    "demand_count": "1",
    "avg_salary": "111175",
    "country": "Philippines"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "1",
    "avg_salary": "111175",
    "country": "Philippines"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "demand_count": "1",
    "avg_salary": "111175",
    "country": "Philippines"
  },
  {
    "skill_id": 195,
    "skills": "sharepoint",
    "demand_count": "1",
    "avg_salary": "109500",
    "country": "Philippines"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "1",
    "avg_salary": "100500",
    "country": "Philippines"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "2",
    "avg_salary": "100190",
    "country": "Philippines"
  },
  {
    "skill_id": 57,
    "skills": "postgresql",
    "demand_count": "1",
    "avg_salary": "98500",
    "country": "Philippines"
  },
  {
    "skill_id": 216,
    "skills": "github",
    "demand_count": "1",
    "avg_salary": "98500",
    "country": "Philippines"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "7",
    "avg_salary": "93793",
    "country": "Philippines"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "6",
    "avg_salary": "93008",
    "country": "Philippines"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "7",
    "avg_salary": "92021",
    "country": "Philippines"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "13",
    "avg_salary": "89998",
    "country": "Philippines"
  },
  {
    "skill_id": 170,
    "skills": "windows",
    "demand_count": "1",
    "avg_salary": "89204",
    "country": "Philippines"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "3",
    "avg_salary": "89058",
    "country": "Philippines"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "2",
    "avg_salary": "87988",
    "country": "Philippines"
  },
  {
    "skill_id": 196,
    "skills": "powerpoint",
    "demand_count": "3",
    "avg_salary": "83800",
    "country": "Philippines"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "9",
    "avg_salary": "81033",
    "country": "Philippines"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "5",
    "avg_salary": "78640",
    "country": "Philippines"
  },
  {
    "skill_id": 184,
    "skills": "dax",
    "demand_count": "1",
    "avg_salary": "72000",
    "country": "Philippines"
  },
  {
    "skill_id": 188,
    "skills": "word",
    "demand_count": "3",
    "avg_salary": "69467",
    "country": "Philippines"
  },
  {
    "skill_id": 202,
    "skills": "ms access",
    "demand_count": "1",
    "avg_salary": "50400",
    "country": "Philippines"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "1",
    "avg_salary": "50400",
    "country": "Philippines"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "1",
    "avg_salary": "50400",
    "country": "Philippines"
  }
]

*/