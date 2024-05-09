# Introduction
📊 Dive into the data job market! Focusing on data analysts roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql_folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from my [SQL Course] (https://lukebarousse.com/sql). It's picked with insights on job titles, salaries, location, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for those top-paying jobs??
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I mastered several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspectrs of the daya analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs.
To identify the highest-paying roles I filtered data analyst position by average yearly salary and country, focusin on remote jobs. This query highlights th high paying oppurtunities in the field.

```sql
SELECT
    job_id,
    job_title_short,
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
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023 in the Philippines:
- **Wide Salary Range:** Top 10 paying data analyst roles span from ₱100,500 to ₱111,174, indicating significance salaryy potential in the field.
- **Diverse Employment:** Companies like Canva, iOPEX, Trusting Social, Pilmico Foods Corportation, Dialpad, and Curated are among those offering high salaries, showing a broad interest across different industries.

### 2. Skills For Top Paying Jobs 
To understand what skills are required for top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH  top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Here's the breakdown of the the most demand skills for data analysts in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.

### 3. In-Demand Skill For Data Analysts
This query helped identify the skills most frequently requested on job postings, directing focus to areas with high demand in the Philippines.
```sql
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
```
Here's the breakdown of the most demand skills for data analyst in 2023 Philippines
- **SQL (Demand Count of 244)** and **Excel (Demand Count of 300)** remain fundamental, emphasizing the need for strong foundation in
Programming and Visualization Tools like **Python (Demand Count of 139)**, **Tableau (Demand Count of 150)**, and **Power BI (Demand Count of 108)**.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are highest paying.

```sql
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
```
Here's a breakdown of the results for top paying skills for Data Analysts in the Philippines:
- Proficiency in programming languages like **Python, R, and SQL** remains highly valued, with average salaries of ₱111,175.
- Tools such as **Jira, Looker, Flow, Zoom, Snowflake, and BigQuery** indicate a growing emphasis on project management, data visualization, workflow automation, and cloud-based analytics platforms.
- **Excel's** enduring relevance, alongside the importance of general office software skills like **SharePoint, Word, and PowerPoint**, underscores the need for a diverse skill set encompassing technical prowess and effective communication abilities.

### 5. Most Optimal Skills to Learn 
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering strategic focus for skill development.

```sql
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
```
Here's a breakdown of the most optimal skills for Data Analysts in the Philippines:

**Key Programming Languages:**
- Proficiency in programming languages like Python and R, 
along with SQL expertise, continues to be highly valued. Professionals adept in these languages command an average salary of $111,175, reflecting the essential role they play in data analysis and manipulation.

**Tools for Enhanced Efficiency**
- Emerging tools such as Jira, Looker, Flow, Zoom, Snowflake, and BigQuery 
are gaining prominence, indicating a growing emphasis on project management, data visualization, workflow automation, and cloud-based analytics platforms. Mastery of these tools not only streamlines processes but also enhances productivity and decision-making capabilities within organizations.

**Enduring Relevance of Office Software Skills:**
- Despite the technological advancements, 
the enduring relevance of Microsoft Excel persists. Alongside Excel, proficiency in general office software skills like SharePoint, Word, and PowerPoint remains crucial. This underscores the need for a diverse skill set encompassing technical prowess and effective communication abilities. Professionals adept in these tools contribute significantly to data-driven decision-making processes while facilitating seamless collaboration and communication within teams.

# What I Learned

Throughout this journey, I've gained my SQL toolkit with some serious skills and knowledge:

**🧩Proficiency in Complex Query Crafting:** I have attained mastery in advanced SQL techniques, adeptly merging tables and employing WITH clauses for sophisticated temporary table operations.

**📊Expertise in Data Aggregation:** I have developed a deep familiarity with GROUP BY operations and have effectively utilized aggregate functions such as COUNT() and AVG() to summarize data.

**🤓Analytical Acumen:** I have honed my skills in real-world puzzle-solving, transforming queries into actionable and insightful SQL solutions.

# Closing Thoughts
Undertaking this project was a transformative experience that not only honed my SQL skills but also provided me with invaluable insights into the dynamic landscape of the data analyst job market. Through meticulous analysis and interpretation of data, I gained a deeper understanding of the trends and patterns shaping this field, empowering me to make informed decisions about skill development and job opportunities.

The findings from this analysis serve as a roadmap for aspiring data analysts, offering guidance on how to navigate the competitive job market effectively. By focusing on acquiring high-demand, high-salary skills highlighted in the exploration, individuals can better position themselves to secure rewarding positions in this ever-evolving industry.

Furthermore, this project underscored the importance of continuous learning and adaptation in the field of data analytics. As technologies and methodologies evolve, it's crucial for professionals to stay updated and embrace emerging trends to remain competitive. This journey emphasized the need for agility and a growth mindset, traits that are essential for long-term success in the data analytics field.

In conclusion, this project not only enhanced my technical skills but also instilled in me a deeper appreciation for the ongoing learning process and the importance of staying adaptable in a rapidly changing landscape. Armed with these insights, I am better prepared to pursue my career goals and contribute meaningfully to the field of data analytics.
