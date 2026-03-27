# ABC Inc. HR Data Analysis with SQL

A structured SQL-based analysis of ABC Inc.'s HR datasets covering 1,000 employees and their 2024 performance reviews. The project applies data preparation, descriptive querying, and advanced SQL analysis to extract actionable workforce insights.

---

## Dataset

**Table 1: employees** (1,000 rows)

| Column | Type | Description |
|---|---|---|
| employee_id | VARCHAR | Unique identifier (PK) |
| full_name | VARCHAR | Employee full name |
| gender | VARCHAR | Gender category |
| department | VARCHAR | Department |
| job_title | VARCHAR | Role/designation |
| employment_type | VARCHAR | Full-time, Contract, or Intern |
| location | VARCHAR | Work location |
| hire_date | DATE | Date of hire |
| monthly_salary_bdt | INT | Monthly salary in BDT |
| manager_id | VARCHAR | FK referencing employee_id |

**Table 2: performance_reviews** (1,000 rows)

| Column | Type | Description |
|---|---|---|
| employee_id | VARCHAR | FK to employees table |
| review_period_start | DATE | Review start date |
| review_period_end | DATE | Review end date |
| performance_rating | INT | Overall rating (1–5) |
| manager_score | INT | Manager evaluation (1–5) |
| peer_score | INT | Peer evaluation (1–5) |
| bonus_pct | DECIMAL | Bonus as % of salary |
| trainings_completed | INT | Trainings completed in 2024 |
| leaves_taken | INT | Leaves taken in 2024 |
| attrition_risk | VARCHAR | Low, Medium, or High |

---

## Data Quality Checks

| Check | Result |
|---|---|
| Missing `manager_id` | 94 employees (likely top-level managers) |
| Missing `location` | 0 |
| Negative salaries | 0 |
| Review dates outside 2024 | 0 |

All data is clean. The 94 null manager IDs represent senior staff with no reporting line above them.

---

## Descriptive Analysis

### Headcount by Department

| Department | Headcount |
|---|---|
| Engineering | 238 |
| Sales | 147 |
| Operations | 126 |
| Marketing | 119 |
| Customer Success | 100 |
| Product | 94 |
| HR | 90 |
| Finance | 86 |

**Engineering has the highest overall headcount** at 238 employees — nearly double the next largest department.

---

### Salary Analysis

**Average Monthly Salary by Department (BDT)**

| Department | Avg Salary |
|---|---|
| Product | 210,305 |
| Finance | 162,532 |
| Engineering | 160,670 |
| Sales | 142,930 |
| Marketing | 126,445 |
| Operations | 116,932 |
| HR | 102,747 |
| Customer Success | 99,689 |

Product is the highest-paid department by a significant margin — over 30% above Engineering and Finance.

**Average Salary by Location (BDT)**

| Location | Avg Salary |
|---|---|
| Sylhet | 147,629 |
| Dhaka | 147,380 |
| Remote | 142,426 |
| Khulna | 141,093 |
| Chattogram | 137,571 |
| Rajshahi | 136,049 |

Sylhet and Dhaka pay the highest on average. The gap across locations is relatively small (~8%), suggesting reasonably uniform pay distribution across branches.

---

### Performance Rating Analysis

**Average Performance Rating by Department**

| Department | Avg Rating |
|---|---|
| Finance | 3.48 |
| Sales | 3.40 |
| Engineering | 3.35 |
| Operations | 3.33 |
| Customer Success | 3.33 |
| HR | 3.28 |
| Product | 3.26 |
| Marketing | 3.25 |

Finance tops performance ratings. All departments cluster between 3.25–3.48, indicating consistent but moderate performance across the organization.

**Manager vs Peer Score Comparison**

| Score Type | Average |
|---|---|
| Manager Score | 3.36 |
| Peer Score | 3.32 |

Managers score employees slightly higher than peers do. The gap is small (0.04), suggesting reasonable alignment between evaluation sources.

---

### Attrition Risk

**Overall Distribution**

| Risk Level | Count |
|---|---|
| High | 712 |
| Medium | 223 |
| Low | 65 |

**71.2% of employees are at High attrition risk** — a critical organizational concern.

**Attrition Risk by Department (High risk count)**

| Department | High | Medium | Low |
|---|---|---|---|
| Engineering | 177 | 47 | 14 |
| Sales | 101 | 35 | 11 |
| Operations | 83 | 30 | 13 |
| Marketing | 82 | 28 | 9 |
| Customer Success | 71 | 23 | 6 |
| HR | 70 | 17 | 3 |
| Product | 69 | 20 | 5 |
| Finance | 59 | 23 | 4 |

Engineering has the highest absolute count of high-risk employees. However, the high attrition risk proportion is similarly elevated across all departments.

---

## Advanced Analysis

### Top 10 Employees by Bonus Amount

| Employee | Department | Monthly Salary | Bonus % | Bonus (BDT) |
|---|---|---|---|---|
| Arif Uddin | Engineering | 296,169 | 13.4% | 39,687 |
| Lamia Haider | Product | 331,014 | 11.1% | 36,743 |
| Sumaiya Alam | Product | 292,121 | 12.2% | 35,639 |
| Tania Talukder | Product | 284,203 | 12.2% | 34,673 |
| Shafiq Anjum | Product | 274,622 | 12.6% | 34,602 |
| Tania Parvin | Sales | 264,785 | 12.8% | 33,892 |
| Shawon Sadiq | Finance | 250,336 | 12.9% | 32,293 |
| Shawon Uddin | Sales | 290,910 | 11.0% | 32,000 |
| Arif Haider | Product | 284,958 | 10.8% | 30,775 |
| Karim Kabir | Finance | 266,602 | 11.3% | 30,126 |

Product dominates the top 10, with 5 of the 10 highest bonuses.

**Average Bonus by Department**

| Department | Avg Bonus (BDT) |
|---|---|
| Product | 12,284 |
| Finance | 10,244 |
| Engineering | 10,073 |
| Sales | 8,955 |
| Marketing | 7,658 |
| Operations | 7,183 |
| Customer Success | 6,411 |
| HR | 6,094 |

Product distributes the largest average bonus, consistent with its highest salary band.

---

### Training and Leaves Correlation

| Trainings Completed | Avg Leaves Taken |
|---|---|
| 0 | 10.66 |
| 1 | 12.24 |
| 2 | 12.21 |
| 3 | 11.53 |
| 4 | 12.71 |
| 5 | 11.59 |
| 6 | 12.46 |
| 7 | 11.29 |

No consistent trend emerges between training completion and leave-taking. Employees who completed 0 trainings took slightly fewer leaves on average, but the differences are too small to draw a strong conclusion.

---

### Manager Span of Control

| Manager ID | Direct Reports |
|---|---|
| E0376 | 10 |
| E0990 | 9 |
| E0828 | 9 |
| E0852 | 8 |
| E0831 | 8 |
| E0736 | 8 |

No manager exceeded 10 direct reports. The widest span is 10 reports under E0376. Workload appears reasonably distributed across managers.

---

### Tenure Analysis

**Average Tenure by Department (Years)**

| Department | Avg Tenure |
|---|---|
| Engineering | 5.64 |
| Marketing | 5.60 |
| Sales | 5.51 |
| Finance | 5.24 |
| Customer Success | 5.18 |
| Operations | 5.14 |
| Product | 5.13 |
| HR | 5.00 |

**Tenure vs Attrition Risk**

| Attrition Risk | Avg Tenure (Years) |
|---|---|
| Low | 5.61 |
| Medium | 5.55 |
| High | 5.29 |

A modest trend exists — employees with **Low attrition risk have slightly longer average tenure** (5.61 years) compared to High-risk employees (5.29 years). Longer-tenured employees may have stronger organizational ties, but the gap is small and tenure alone is not a reliable attrition predictor.

---

## Tools Used

- SQLite (via DB Browser for SQLite)
- SQL — joins, aggregations, grouping, filtering, date functions

## Files

| File | Description |
|---|---|
| `abc_inc_hr.db` | SQLite database with both tables |
| `abc_inc_hr.sqbpro` | DB Browser project file |

---

## Key Takeaways

- **71% of employees are at high attrition risk** — this is the most urgent finding and warrants immediate HR intervention across all departments.
- **Product is the highest-compensated and highest-bonus department** despite not having the largest headcount.
- **Manager and peer evaluations are closely aligned**, suggesting a fair and consistent review culture.
- **Tenure slightly correlates with lower attrition risk**, but the effect is small — salary, engagement, and management quality likely play bigger roles.
- **No manager has an unmanageable span of control**, with the maximum being 10 direct reports.
