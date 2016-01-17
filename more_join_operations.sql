/* SQLZOO: More JOIN operations */ 
/* 
Movie Database 
This tutorial introduces the notion of a join. The database consists of three tables movie , actor and casting .

movie  actor  casting 
id  id  movieid 
title  name  actorid 
yr    ord 
director     
budget     
gross     
*/ 
/* 
1. 
List the films where the yr is 1962 [Show id, title] 
*/ 
SELECT id, 
       title 
FROM   movie 
WHERE  yr = 1962 

/* 
2. 
Give year of 'Citizen Kane'. 
*/ 
SELECT yr 
FROM   movie 
WHERE  title = 'Citizen Kane' 

/* 
3. 
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/ 
SELECT id, 
       title, 
       yr 
FROM   movie 
WHERE  title LIKE '%Star Trek%' 
ORDER  BY yr 

/* 
4. 
What are the titles of the films with id 11768, 11955, 21191 
*/ 
SELECT title 
FROM   movie 
WHERE  id IN ( 11768, 11955, 21191 ) 

/* 
5. 
What id number does the actress 'Glenn Close' have? 
*/ 
SELECT id 
FROM   actor 
WHERE  NAME LIKE '%Glenn Close%' 

/* 
6. 
What is the id of the film 'Casablanca' 
*/ 
SELECT id 
FROM   movie 
WHERE  title LIKE '%Casablanca%' 

/* 
7. 
Obtain the cast list for 'Casablanca'. 

what is a cast list? 
Use movieid=11768, this is the value that you obtained in the previous question. 
*/ 
SELECT a.NAME 
FROM   actor a 
       JOIN casting b 
         ON a.id = b.actorid 
WHERE  b.movieid = 11768 

/* 
8. 
Obtain the cast list for the film 'Alien' 
*/ 
SELECT a.NAME 
FROM   actor a 
       JOIN casting b 
         ON a.id = b.actorid 
WHERE  b.movieid = (SELECT id 
                    FROM   movie 
                    WHERE  title = 'Alien') 

/* 
9. 
List the films in which 'Harrison Ford' has appeared 
*/ 
SELECT a.title 
FROM   movie a 
       JOIN casting b 
         ON a.id = b.movieid 
WHERE  b.actorid = (SELECT id 
                    FROM   actor 
                    WHERE  NAME = 'Harrison Ford') 

/* 
10. 
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/ 
SELECT a.title 
FROM   movie a 
       JOIN casting b 
         ON a.id = b.movieid 
WHERE  b.actorid = (SELECT id 
                    FROM   actor 
                    WHERE  NAME = 'Harrison Ford') 
       AND b.ord > 1 

/* 
11. 
List the films together with the leading star for all 1962 films. 
*/ 
SELECT a.title, 
       b.NAME 
FROM   movie a 
       JOIN casting c 
         ON a.id = c.movieid 
       JOIN actor b 
         ON b.id = c.actorid 
WHERE  c.ord = 1 
       AND a.yr = 1962 

/* 
12. 
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/ 
SELECT a.yr, 
       Count(b.NAME) 
FROM   movie a 
       JOIN casting c 
         ON a.id = c.movieid 
       JOIN actor b 
         ON b.id = c.actorid 
WHERE  b.NAME = 'John Travolta' 
GROUP  BY a.yr 
HAVING Count(b.NAME) > 2 

/* 
13. 
List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
*/ 
SELECT a.title, 
       b.NAME 
FROM   casting c 
       JOIN actor b 
         ON b.id = c.actorid 
       JOIN movie a 
         ON a.id = c.movieid 
WHERE  a.id IN (SELECT movieid 
                FROM   casting 
                WHERE  actorid = (SELECT id 
                                  FROM   actor 
                                  WHERE  NAME = 'Julie Andrews')) 
       AND c.ord = 1 

/* 
14. 
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
*/ 
SELECT b.NAME 
FROM   actor b 
       JOIN casting c 
         ON b.id = c.actorid 
       JOIN movie a 
         ON a.id = c.movieid 
WHERE  c.ord = 1 
GROUP  BY b.NAME 
HAVING Count(a.title) >= 30 
ORDER  BY b.NAME 

/* 
15. 
List the films released in the year 1978 ordered by the number of actors in the cast. 
*/ 
SELECT a.title, 
       Count(c.actorid) AS cast 
FROM   movie a 
       JOIN casting c 
         ON a.id = c.movieid 
WHERE  a.yr = 1978 
GROUP  BY a.title 
ORDER  BY cast DESC 

/* 
16. 
List all the people who have worked with 'Art Garfunkel'. 
*/ 
SELECT DISTINCT b.NAME 
FROM   actor b 
       JOIN casting c 
         ON b.id = c.actorid 
WHERE  b.NAME != 'Art Garfunkel' 
       AND c.movieid IN (SELECT movieid 
                         FROM   casting 
                         WHERE  actorid = (SELECT id 
                                           FROM   actor 
                                           WHERE  NAME = 'Art Garfunkel')) 