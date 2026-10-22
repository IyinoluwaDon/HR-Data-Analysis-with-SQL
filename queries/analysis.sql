-- name: data_quality
SELECT COUNT(*) AS employees, COUNT(DISTINCT employee_id) AS unique_ids,
 SUM(CASE WHEN manager_id IS NULL OR TRIM(manager_id)='' THEN 1 ELSE 0 END) AS missing_manager,
 SUM(CASE WHEN location IS NULL OR TRIM(location)='' THEN 1 ELSE 0 END) AS missing_location,
 SUM(CASE WHEN monthly_salary_bdt < 0 THEN 1 ELSE 0 END) AS negative_salary
FROM employees;

-- name: department_headcount_salary
SELECT department, COUNT(*) AS headcount, ROUND(AVG(monthly_salary_bdt),2) AS average_monthly_salary_bdt
FROM employees GROUP BY department ORDER BY headcount DESC;

-- name: location_salary
SELECT location, COUNT(*) AS headcount, ROUND(AVG(monthly_salary_bdt),2) AS average_monthly_salary_bdt
FROM employees GROUP BY location ORDER BY average_monthly_salary_bdt DESC;

-- name: review_coverage
SELECT COUNT(*) AS reviews, COUNT(DISTINCT employee_id) AS reviewed_employees,
 MIN(review_period_start) AS first_period_start, MAX(review_period_end) AS last_period_end
FROM performance_reviews;

-- name: department_performance
SELECT e.department, COUNT(*) AS reviews, ROUND(AVG(pr.performance_rating),3) AS mean_rating,
 ROUND(AVG(pr.manager_score),3) AS mean_manager_score, ROUND(AVG(pr.peer_score),3) AS mean_peer_score
FROM employees e JOIN performance_reviews pr USING(employee_id)
GROUP BY e.department ORDER BY mean_rating DESC;

-- name: recorded_attrition_labels
SELECT attrition_risk, COUNT(*) AS reviews, ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM performance_reviews),2) AS pct
FROM performance_reviews GROUP BY attrition_risk;

-- name: department_attrition_labels
SELECT e.department, pr.attrition_risk, COUNT(*) AS reviews,
 ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY e.department),2) AS department_pct
FROM employees e JOIN performance_reviews pr USING(employee_id)
GROUP BY e.department,pr.attrition_risk ORDER BY e.department,pr.attrition_risk;

-- name: estimated_bonus_by_department
SELECT e.department, ROUND(AVG(e.monthly_salary_bdt*pr.bonus_pct),2) AS average_monthly_base_bonus_bdt
FROM employees e JOIN performance_reviews pr USING(employee_id)
GROUP BY e.department ORDER BY average_monthly_base_bonus_bdt DESC;

-- name: training_and_leave
SELECT trainings_completed, COUNT(*) AS reviews, ROUND(AVG(leaves_taken),2) AS average_leaves
FROM performance_reviews GROUP BY trainings_completed ORDER BY trainings_completed;

-- name: reporting_spans
SELECT manager_id,COUNT(*) AS direct_reports FROM employees
WHERE manager_id IS NOT NULL AND TRIM(manager_id)!=''
GROUP BY manager_id ORDER BY direct_reports DESC,manager_id;

-- name: missing_manager_references
SELECT COUNT(*) AS unmatched_manager_ids FROM employees e
LEFT JOIN employees manager ON e.manager_id=manager.employee_id
WHERE e.manager_id IS NOT NULL AND TRIM(e.manager_id)!='' AND manager.employee_id IS NULL;

-- name: tenure_at_review_end
SELECT pr.attrition_risk,
 ROUND(AVG((JULIANDAY(pr.review_period_end)-JULIANDAY(e.hire_date))/365.25),2) AS mean_tenure_years
FROM employees e JOIN performance_reviews pr USING(employee_id)
GROUP BY pr.attrition_risk ORDER BY mean_tenure_years DESC;
