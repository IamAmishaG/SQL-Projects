----CASE STUDY 1 
--1.	Number of jobs reviewed
SELECT ds AS Dates, ROUND((COUNT(job_id)/SUM(time_spent))*3600) AS "Jobs Reviewed per Hour per Day" 
FROM job_data 
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30' 
GROUP BY ds; 


--2.	Throughput:
SELECT ROUND(COUNT(event)/SUM(time_spent), 2) AS "Weekly Throughput" FROM job_data; 
SELECT ds AS Dates, ROUND(COUNT(event)/SUM(time_spent), 2) AS "Daily Throughput" FROM job_data 
GROUP BY ds 
ORDER BY ds; 


--3.	Percentage share of each language:
SELECT *, TRUNCATE(shares_of_lang/ SUM(shares_of_lang) OVER ()*100 ,1) AS Percentage 
FROM 
	(SELECT  language, COUNT(*) AS shares_of_lang 
	FROM job_data 
	GROUP BY 1) sub;


--4.	Duplicate rows: 
SELECT actor_id, COUNT(*) AS Duplicates 
FROM job_data 
GROUP BY actor_id 
HAVING COUNT(*) > 1; 



---- CASE STUDY 2
--1.	User Engagement: 
SELECT EXTRACT(WEEK FROM occurred_at) AS "Week Numbers", COUNT(DISTINCT user_id) AS "Weekly Active Users" FROM events 
WHERE event_type = 'engagement' 
GROUP BY 1;
 

--2.	User Growth:
SELECT Months, Users, ROUND(((Users/LAG(Users, 1) OVER (ORDER BY Months) - 1)*100), 2) AS "Growth in %" 
FROM 
( 
SELECT EXTRACT(MONTH FROM created_at) AS Months, COUNT(activated_at) AS Users 
FROM users 
WHERE activated_at NOT IN("") 
GROUP BY 1 
ORDER BY 1 
) sub; 


--3.	Weekly Retention: 
SELECT first AS "Week Numbers", 
SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS "Week 0", 
SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS "Week 1", 
SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS "Week 2", 
SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS "Week 3", 
SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS "Week 4", 
SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS "Week 5", 
SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS "Week 6", 
SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS "Week 7", 
SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS "Week 8", 
SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS "Week 9", 
SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS "Week 10", 
SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS "Week 11", 
SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS "Week 12", 
SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS "Week 13", 
SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS "Week 14", 
SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS "Week 15", 
SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS "Week 16", 
SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS "Week 17", 
SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS "Week 18", 
FROM 
( 
SELECT m.user_id, m.login_week, n.first, m.login_week - first AS week_number 
FROM 
(SELECT user_id, EXTRACT(WEEK FROM occurred_at) AS login_week FROM events GROUP BY 1, 2) m, 
(SELECT user_id, MIN(EXTRACT(WEEK FROM occurred_at)) AS first FROM events 
GROUP BY 1) n 
WHERE m.user_id = n.user_id 
) sub 
GROUP BY first 
ORDER BY first; 


--4.	Weekly Engagement:
SELECT EXTRACT(WEEK FROM occurred_at) AS "Week Numbers", 
COUNT(DISTINCT CASE WHEN device IN('dell inspiron notebook') THEN user_id ELSE NULL END) AS "Dell Inspiron Notebook", 
COUNT(DISTINCT CASE WHEN device IN('iphone 5') THEN user_id ELSE NULL END) AS 
"iPhone 5", 
COUNT(DISTINCT CASE WHEN device IN('iphone 4s') THEN user_id ELSE NULL END) AS "iPhone 4S", 
COUNT(DISTINCT CASE WHEN device IN('windows surface') THEN user_id ELSE NULL END) AS "Windows Surface", 
COUNT(DISTINCT CASE WHEN device IN('macbook air') THEN user_id ELSE NULL END) AS "Macbook Air", 
COUNT(DISTINCT CASE WHEN device IN('iphone 5s') THEN user_id ELSE NULL END) AS "iPhone 5S", 
COUNT(DISTINCT CASE WHEN device IN('macbook pro') THEN user_id ELSE NULL END) AS "Macbook Pro", 
COUNT(DISTINCT CASE WHEN device IN('kindle fire') THEN user_id ELSE NULL END) AS "Kindle Fire", 
COUNT(DISTINCT CASE WHEN device IN('ipad mini') THEN user_id ELSE NULL END) AS 
"iPad Mini", 
COUNT(DISTINCT CASE WHEN device IN('nexus 7') THEN user_id ELSE NULL END) AS 
"Nexus 7", 
COUNT(DISTINCT CASE WHEN device IN('nexus 5') THEN user_id ELSE NULL END) AS "Nexus 5", 
COUNT(DISTINCT CASE WHEN device IN('samsung galaxy s4') THEN user_id ELSE NULL END) AS "Samsung Galaxy S4", 
COUNT(DISTINCT CASE WHEN device IN('lenovo thinkpad') THEN user_id ELSE NULL END) AS "Lenovo Thinkpad", 
COUNT(DISTINCT CASE WHEN device IN('samsumg galaxy tablet') THEN user_id ELSE NULL END) AS "Samsumg Galaxy Tablet", 
COUNT(DISTINCT CASE WHEN device IN('acer aspire notebook') THEN user_id ELSE NULL END) AS "Acer Aspire Notebook", 
COUNT(DISTINCT CASE WHEN device IN('asus chromebook') THEN user_id ELSE NULL END) AS "Asus Chromebook", 
COUNT(DISTINCT CASE WHEN device IN('htc one') THEN user_id ELSE NULL END) AS "HTC One", 
COUNT(DISTINCT CASE WHEN device IN('nokia lumia 635') THEN user_id ELSE NULL END) AS "Nokia Lumia 635", 
COUNT(DISTINCT CASE WHEN device IN('samsung galaxy note') THEN user_id ELSE NULL END) AS "Samsung Galaxy Note", 
COUNT(DISTINCT CASE WHEN device IN('acer aspire desktop') THEN user_id ELSE NULL END) AS "Acer Aspire Desktop", 
COUNT(DISTINCT CASE WHEN device IN('mac mini') THEN user_id ELSE NULL END) AS "Mac Mini", 
COUNT(DISTINCT CASE WHEN device IN('hp pavilion desktop') THEN user_id ELSE NULL END) AS "HP Pavilion Desktop", 
COUNT(DISTINCT CASE WHEN device IN('dell inspiron desktop') THEN user_id ELSE NULL END) AS "Dell Inspiron Desktop", 
COUNT(DISTINCT CASE WHEN device IN('ipad air') THEN user_id ELSE NULL END) AS 
"iPad Air", 
COUNT(DISTINCT CASE WHEN device IN('amazon fire phone') THEN user_id ELSE NULL END) AS "Amazon Fire Phone", 
COUNT(DISTINCT CASE WHEN device IN('nexus 10') THEN user_id ELSE NULL END) AS "Nexus 10" 
FROM events 
WHERE event_type = 'engagement' 
GROUP BY 1 
ORDER BY 1; 


--5.	Email Engagement: 
SELECT Week, 
ROUND((weekly_digest/total*100),2) AS "Weekly Digest Rate", 
ROUND((email_opens/total*100),2) AS "Email Open Rate", 
ROUND((email_clickthroughs/total*100),2) AS "Email Clickthrough Rate", 
ROUND((reengagement_emails/total*100),2) AS "Reengagement Email Rate" 
FROM 
( 
SELECT EXTRACT(WEEK FROM occurred_at) AS Week, 
COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_digest, 
COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS email_opens, 
COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthroughs, 
COUNT(CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) 
AS reengagement_emails, 
COUNT(user_id) AS total 
FROM email_events 
GROUP BY 1 
) sub 
GROUP BY 1 
ORDER BY 1; 
