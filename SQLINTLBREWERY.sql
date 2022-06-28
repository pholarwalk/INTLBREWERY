CREATE TABLE INTERNATIONAL_BREWERIES 
(SALES_ID INT, SALES_REP VARCHAR, EMAILS VARCHAR, BRANDS VARCHAR,
 PLANT_COST INT, UNIT_PRICE INT, QUANTITY INT, COST INT, PROFIT INT,
 COUNTRIES VARCHAR, REGION VARCHAR, MONTHS VARCHAR, YEARS INT)

SELECT DISTINCT COUNTRIES
FROM INTERNATIONAL_BREWERIES

				--PROFIT ANALYSIS--

/* Within the space of the last three years, what was the
profit worth of the breweries,inclusive of the anglophone 
and the francophone territories?*/

SELECT SUM(PROFIT) AS TOTAL_REVENUE
FROM INTERNATIONAL_BREWERIES;

/*Compare the total profit between these two territories in 
order for the territory manager,Mr. Stone made a strategic
decision that will aid profit maximization in 2020.*/

SELECT  SUM(PROFIT) AS TOTAL_REVENUE,
CASE	WHEN COUNTRIES in('Benin','Senegal','Togo')THEN 'francophone'
		WHEN COUNTRIES in('Nigeria','Ghana')THEN 'anglophone'
		END AS LANGUAGE
FROM INTERNATIONAL_BREWERIES
GROUP BY  LANGUAGE;


 --Country that generated the highest profit in 2019
 SELECT countries,years,sum(profit) as total_profit
 FROM INTERNATIONAL_BREWERIES
 where years = 2019
 group by countries,years
 order BY total_profit desc
 limit 1;
 

--- Help him find the year with the highest profit.
 SELECT years , sum(profit) as total_profit
 FROM INTERNATIONAL_BREWERIES
 group by years
 order by total_profit desc
 limit 1;
 
 ---Which month in the three years was the least profit generated?
select months, sum(profit) as TP
FROM INTERNATIONAL_BREWERIES
GROUP BY MONTHS
ORDER BY TP
LIMIT 1;

---What was the minimum profit in the month of December 2018?
select months, years, min(profit) as TP
FROM INTERNATIONAL_BREWERIES
where years = 2018 AND months = 'December'
GROUP BY MONTHS, YEARS;

--Compare the profit in percentage for each of the month in 2019
SELECT MONTHS, SUM(PROFIT) AS TP,SUM(PROFIT)* 100/
(SELECT SUM(PROFIT) AS YEARLY
FROM INTERNATIONAL_BREWERIES
WHERE YEARS = 2019)AS PERC
FROM INTERNATIONAL_BREWERIES
WHERE YEARS = 2019
GROUP BY MONTHS
ORDER BY PERC DESC;

--- Which particular brand generated the highest profit in Senegal?
SELECT BRANDS, COUNTRIES, SUM(PROFIT) AS TP
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES = 'Senegal'
GROUP BY BRANDS, COUNTRIES
ORDER BY TP DESC
LIMIT 1;

					/*BRAND ANALYSIS*/
/* Within the last two years, the brand manager wants to know the 
top three brands consumed in the francophone countries?*/

SELECT BRANDS, SUM(quantity)AS DRINK
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES IN ('Senegal', 'Togo', 'Benin') 
	AND YEARS IN (2018,2019)
GROUP BY BRANDS
ORDER BY DRINK DESC
LIMIT 3;

---Find out the top two choice of consumer brands in Ghana
SELECT BRANDS, SUM(quantity)AS DRINK
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES = 'Ghana'
GROUP BY BRANDS
ORDER BY DRINK DESC
LIMIT 2;

/* Find out the details of beers consumed in the past three years
in the most oil reached country in West Africa.*/
SELECT BRANDS,PROFIT, QUANTITY, YEARS
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES = 'Nigeria'
AND BRANDS IN ('hero', 'castle lite', 'budweiser','trophy','eagle lager');

 
--Favorites malt brand in Anglophone region between 2018 and 2019
SELECT BRANDS, SUM(quantity)AS DRINK
FROM INTERNATIONAL_BREWERIES
WHERE BRANDS Like '%malt%'
	AND YEARS IN (2018,2019) AND COUNTRIES IN ('Nigeria','Ghana')
GROUP BY BRANDS
ORDER BY DRINK DESC
LIMIT 1;

-- Which brands sold the highest in 2019 in Nigeria?
SELECT BRANDS,SUM(QUANTITY)AS DRINK
FROM INTERNATIONAL_BREWERIES
WHERE YEARS = 2019 AND COUNTRIES ='Nigeria'
GROUP BY BRANDS
ORDER BY DRINK DESC
LIMIT 1;

-- Favorites brand in South_South region in Nigeria?
SELECT BRANDS, SUM(QUANTITY) AS HOWMUCH
FROM INTERNATIONAL_BREWERIES
WHERE REGION = 'southsouth' AND COUNTRIES ='Nigeria'
GROUP BY BRANDS 
ORDER BY HOWMUCH DESC;

-- . BeER consumption in Nigeria
SELECT BRANDS, SUM (QUANTITY) AS HOWMUCH
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES ='Nigeria' AND BRANDS IN ('hero', 'castle lite', 'budweiser','trophy','eagle lager')
GROUP BY BRANDS
ORDER BY HOWMUCH DESC;

--  Level of consumption of Budweiser in the regions in Nigeria
SELECT BRANDS, SUM (QUANTITY) AS HOWMUCH
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES ='Nigeria' AND BRANDS = 'budweiser'
GROUP BY BRANDS;

--Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
SELECT BRANDS, SUM (QUANTITY) AS HOWMUCH
FROM INTERNATIONAL_BREWERIES
WHERE COUNTRIES ='Nigeria' AND BRANDS = 'budweiser' AND YEARS = 2019
GROUP BY BRANDS;

				/*COUNTRIES ANALYSIS*/
-- . Country with the highest consumption of beer?
SELECT COUNTRIES,SUM (QUANTITY) AS HOWMUCH
FROM INTERNATIONAL_BREWERIES
WHERE BRANDS IN ('hero', 'castle lite', 'budweiser','trophy','eagle lager')
GROUP BY COUNTRIES
ORDER BY HOWMUCH DESC
LIMIT 1;

-- Highest sales personnel of Budweiser in Senegal
SELECT SALES_REP, SUM(QUANTITY) AS HOWMANY
FROM INTERNATIONAL_BREWERIES
WHERE BRANDS = 'budweiser' AND COUNTRIES = 'Senegal'
GROUP BY SALES_REP
ORDER BY HOWMANY DESC
LIMIT 1; 
	
--- Country with the highest profit of the fourth quarter in 2019?
SELECT COUNTRIES, SUM(PROFIT) AS TOPSOLD
FROM INTERNATIONAL_BREWERIES
WHERE MONTHS IN ('October', 'December' ,'November') AND YEARS = 2019
GROUP BY COUNTRIES
ORDER BY TOPSOLD DESC
LIMIT 1;

				

