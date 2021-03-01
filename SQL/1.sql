/* question 1*/
SELECT country,AVG (valence) FROM tracks LEFT JOIN plays ON tracks.id=plays.track_id 
 LEFT JOIN echonest ON tracks.id=echonest.id GROUP BY country ;

/*question 3 */
SELECT DISTINCT(NAME) FROM artists WHERE NAME LIKE '%band%' OR name LIKE '%Band%';
 
 /*question 4*/
SELECT DISTINCT(plays.track_id),artists.name,tracks.name,artists.id FROM plays 
JOIN tracks ON plays.track_id=tracks.id
LEFT JOIN artists ON tracks.artist_id=artists.id 
WHERE artists.name='Dua Lipa';

SELECT * from echonest
LEFT JOIN tracks ON tracks.id=echonest.id 
WHERE tracks.artist_id=572
;

SELECT DISTINCT(plays.track_id),artists.name,tracks.name,artists.id FROM plays 
INNER  JOIN tracks ON plays.track_id=tracks.id
inner JOIN artists ON tracks.artist_id=artists.id 
INNER JOIN echonest ON echonest.id=tracks.id
WHERE artists.name='Dua Lipa';

/* question 5*/
SELECT * FROM echonest LEFT JOIN plays ON echonest.id=plays.track_id WHERE country='nl' ORDER BY danceability DESC;


/* question 6*/
SELECT SUM(streams),  artists.name FROM artists 
LEFT JOIN tracks ON tracks.artist_id = artists.id
 left join plays ON plays.track_id = tracks.id 
WHERE artists.name LIKE '%a %' OR artists.name LIKE '%a' GROUP BY artists.name order BY SUM(streams) DESC

/*question 7*/
SELECT SUM(streams) FROM plays LEFT JOIN tracks ON plays.track_id=tracks.id WHERE NAME ='Perfect' AND artist_id='7' AND DATE='2017-03-02' ;

/* question 8*/ 
SELECT artists.name, DATE,COUNT(DISTINCT(tracks.id)) FROM artists 
LEFT JOIN tracks ON tracks.artist_id = artists.id 
left join plays ON plays.track_id = tracks.id WHERE tracks.artist_id=artists.id 
AND artists.name='Bruno Mars' AND DATE BETWEEN '2015-12-31' AND '2017-01-01';  

/* question 9 */
SELECT count(distinct(DATE)),artists.name,tracks.name,plays.country FROM artists 
LEFT JOIN tracks ON artists.id=tracks.artist_id 
LEFT JOIN plays ON tracks.id= plays.track_id 
WHERE artists.name LIKE '%david bowie%' AND tracks.name LIKE '%Heroes - 1999 Remastered Version%' AND plays.country= 'NL' ;

/* question 10 */
SELECT distinct(echonest.id),avg(echonest.liveness),plays.country  FROM echonest 
LEFT JOIN plays ON plays.track_id=echonest.id
WHERE plays.country='pt'; 

SELECT distinct(echonest.id),avg(echonest.liveness),plays.country  FROM echonest 
LEFT JOIN plays ON plays.track_id=echonest.id
WHERE plays.country='es'; 



/* question 11*/
SELECT * FROM plays 
LEFT JOIN tracks ON plays.track_id=tracks.id
LEFT JOIN artists ON tracks.artist_id=artists.id
WHERE artists.name='adele' AND plays.country='jp'
ORDER BY plays.position;

/* questions 12 */
SELECT plays.country ,count(DISTINCT(artists.id)) FROM artists 
LEFT JOIN tracks ON artists.id=tracks.artist_id 
LEFT JOIN plays ON tracks.id= plays.track_id 
GROUP BY plays.country ORDER BY count(DISTINCT(artists.id)) DESC 
; 

/* question 13 */ 
SELECT artists.name,SUM(plays.streams) FROM artists 
LEFT JOIN tracks ON artists.id=tracks.artist_id 
LEFT JOIN plays ON tracks.id= plays.track_id
WHERE artists.name = 'ABBA' AND plays.country='no';

SELECT artists.name,SUM(plays.streams) FROM artists 
LEFT JOIN tracks ON artists.id=tracks.artist_id 
LEFT JOIN plays ON tracks.id= plays.track_id
WHERE artists.name = 'ABBA' AND plays.country='se';

/* question 14*/ 
SELECT * FROM artists 
LEFT JOIN tracks ON artists.id=tracks.artist_id 
LEFT JOIN plays ON tracks.id= plays.track_id
WHERE artists.name='Daft Punk' AND tracks.name ='Da Funk'
LIMIT 1000;

/* question 15*/



SELECT plays.country,COUNT(plays.date) FROM plays 
LEFT JOIN tracks ON plays.track_id=tracks.id
LEFT JOIN artists ON tracks.artist_id=artists.id
WHERE plays.country='gb' AND plays.streams>1000000
;


SELECT * FROM plays
WHERE plays.country='gb' AND plays.streams>1000000;
