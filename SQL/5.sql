SELECT treat,
		COUNT(userid) AS N,
		COUNT(userid) / (SELECT COUNT(userid) FROM quiz3) AS perc 
FROM quiz3 GROUP BY treat ;

SELECT treat, AVG(converted) FROM quiz3 GROUP BY treat;

SELECT treat,exposed,COUNT(userid) AS N ,avg(converted) FROM quiz3  where treat='1' GROUP BY exposed ;



SELECT treat,
 count(os_phone) 
 FROM quiz3 GROUP BY treat;
 
SELECT COUNT(os_phone)FROM quiz3 ;
#21216

SELECT treat,
COUNT(gender),
gender
FROM quiz3 WHERE treat =0  GROUP BY treat,gender;
#6286


SELECT treat, AVG(nfriends)
FROM quiz3 GROUP BY treat;


