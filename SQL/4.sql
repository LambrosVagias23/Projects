SELECT COUNT(DISTINCT(plays.date)) FROM plays INNER JOIN tracks ON plays.track_id=tracks.id WHERE plays.country='au' AND  lower(tracks.name) = LOWER('Feel Good Inc');

SELECT track_id,date,plays.streams FROM plays WHERE plays.country ='es' AND plays.date LIKE "%2018%" ORDER BY plays.streams DESC;

SELECT * FROM artists WHERE NAME='eminem';




SELECT treat ,COUNT(userid) AS N ,COUNT(userid)/(SELECT COUNT(userid)FROM facebook_exam20) AS perc FROM facebook_exam20 GROUP BY treat;

SELECT treat,AVG(converted) FROM facebook_exam20 GROUP BY treat;

SELECT treat ,exposed,COUNT(userid) AS n FROM facebook_exam20 WHERE treat ='1' GROUP BY exposed;

SELECT treat ,exposed,COUNT(userid)AS n ,AVG(converted) FROM facebook_exam20 WHERE treat='1' GROUP BY exposed;