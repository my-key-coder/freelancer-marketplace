-- Inserting new project

INSERT INTO projects(client_id, title, category, budget, post_date)
	VALUES(1, 'Clean data', 'Data Analysis', 250, '2025-07-15');
-- Top earning freelancers
SELECT
	f.name as freelancer_name,
	SUM(p.amount) AS total_earned
FROM
	freelancers f
JOIN project_work w ON
	f.freelancer_id = w.freelancer_id
JOIN payments p ON
	w.work_id = p.work_id
GROUP BY
	f.name
ORDER BY
	total_earned DESC;

-- Most profitable category
SELECT
	pr.category,
	SUM(p.amount) AS total_payment
FROM
	projects pr
JOIN 
	project_work pw ON pr.project_id = pw.project_id
JOIN
	payments p ON pw.work_id = p.work_id
GROUP BY
	pr.category
ORDER BY
	total_payment DESC;

-- Monthly project volume trends
SELECT 
	DATE_TRUNC('month', post_date) AS month,
	COUNT(*) total_projects
FROM projects
GROUP BY
	month
ORDER BY
	month;

-- Platform revenue report
SELECT
	DATE_TRUNC('month', payment_date) AS month,
	SUM(platform_fee) AS total_platfrom_revenue
FROM
	payments
GROUP BY
	month
ORDER BY
	month;

-- Most active client
SELECT
	c.name AS client,
	COUNT(*) AS total_project_post
FROM clients c
JOIN
	projects p ON c.client_id = p.client_id
GROUP BY
	c.name
ORDER BY
	 total_project_post DESC
LIMIT 1;
	
-- Freelancer Growth over time
WITH first_proposal AS (
	SELECT freelancer_id,
	MIN(proposal_date) AS first_proposal_date
	FROM proposals
	GROUP BY
	freelancer_id
)
SELECT DATE_TRUNC('month', first_proposal_date) AS joined_month,
	COUNT(*) AS new_freelancers
FROM first_proposal
GROUP BY joined_month
ORDER BY joined_month;

-- Average complition time per category
SELECT
	pr.category,
	ROUND(AVG(w.end_date - w.start_date), 2) AS avg_days_to_complete
FROM project_work w
JOIN
	projects pr 
ON w.project_id = pr.project_id
WHERE w.status = 'Completed'
GROUP BY
	pr.category
ORDER BY
	avg_days_to_complete;


-- Top clients by total spend
SELECT 
	c.name AS client_name,
	SUM(p.amount) AS total_spenT
FROM clients c
JOIN
	projects pr
ON c.client_id = pr.client_id
JOIN
	project_work w
ON  pr.project_id = w.project_id
JOIN
	payments p
ON	w.work_id = p.work_id
GROUP BY
	c.name
ORDER BY
	total_spent DESC;


	
	


	
	