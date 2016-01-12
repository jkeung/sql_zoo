/* SQLZOO: SUM and COUNT */ 
/* 
1. 
Show the total population of the world. 
world(name, continent, area, population, gdp) 
*/ 
SELECT Sum(population) 
FROM   world 

/* 
2. 
List all the continents - just once each. 
*/ 
SELECT DISTINCT( continent ) 
FROM   world 

/* 
3. 
Give the total GDP of Africa 
*/ 
SELECT Sum(gdp) 
FROM   world 
WHERE  continent = 'Africa' 

/* 
4. 
How many countries have an area of at least 1000000 
*/ 
SELECT Count(NAME) 
FROM   world 
WHERE  area >= 1000000 

/* 
5. 
What is the total population of ('France','Germany','Spain') 
*/ 
SELECT Sum(population) 
FROM   world 
WHERE  NAME IN ( 'France', 'Germany', 'Spain' ) 

/* 
6. 
For each continent show the continent and number of countries. 
*/ 
SELECT continent, 
       Count(NAME) 
FROM   world 
GROUP  BY continent 

/* 
7. 
For each continent show the continent and number of countries with populations of at least 10 million.
*/ 
SELECT continent, 
       Count(NAME) 
FROM   world 
WHERE  population >= 10000000 
GROUP  BY continent 

/* 
8. 
List the continents that have a total population of at least 100 million. 
*/ 
SELECT continent 
FROM   world 
GROUP  BY continent 
HAVING Sum(population) >= 100000000 