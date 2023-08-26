# The World Bank's international debt data
SELECT 
    *
FROM
    international_debt; 


# Finding the number of distinct countries
SELECT 
    COUNT(DISTINCT country_name) as no_of_countries
FROM
    international_debt;


# Finding out the distinct debt indicators
SELECT DISTINCT
    indicator_code AS distinct_indicators
FROM
    international_debt;


# Totaling the amount of debt owed by the countries
SELECT 
    ROUND(SUM(debt) / 1000000, 2) AS total_debt
FROM
    international_debt;


# Country with the highest debt
SELECT 
    country_name, ROUND(SUM(debt), 2) AS total_debt
FROM
    international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;


# Average amount of debt across indicators
SELECT 
    indicator_code, AVG(debt) AS average_debt
FROM
    international_debt
GROUP BY indicator_code
ORDER BY average_debt DESC; 


# The highest amount of principal repayments
SELECT 
    country_name, 
    indicator_name,
    debt
FROM international_debt
WHERE debt = (SELECT 
                 MAX(debt)
             FROM international_debt
             WHERE indicator_name LIKE 'Principal repayments %'); 
             

# The most common debt indicator
SELECT 
    indicator_code, COUNT(indicator_code) AS indicator_count
FROM
    international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC;

# Other viable debt issues
SELECT 
	country_name ,indicator_code, sum(debt) AS Total_debt
FROM
    international_debt
GROUP BY country_name, indicator_code
ORDER BY Total_debt DESC, indicator_code DESC
LIMIT 10;





