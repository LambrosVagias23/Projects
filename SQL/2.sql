/* a) How many distinct (=unique) artists are in the dataset?*/

SELECT COUNT(DISTINCT id) FROM artists;
/* 14,269 */


SELECT distinct(tracks.id) FROM tracks ;
/* How many distinct (=unique) tracks are in the dataset? */ 

SELECT COUNT(DISTINCT id) FROM tracks ;
/* 70.116 */ 

/* What is the second highest amount of daily streams in the dataset for a given track? In which country did it occur, and on what date? */ 

SELECT DATE, country, streams FROM plays ORDER BY streams DESC LIMIT 100; 
/* 2018-06-29 , us, 5,219,711 

/*How many countries have data available on 25-04-2015? */

SELECT COUNT(DISTINCT country) FROM plays WHERE DATE ="2015-04-25";
/* 53*/ 

/* Please give the ID for the artist “Aloe Blacc” */ 
SELECT id FROM artists WHERE NAME ='Aloe Blacc' ;
/* 1137*/

/*How many artists contain the name: “Justin” in the dataset?*/ 
SELECT name FROM artists WHERE NAME LIKE '%justin%' ;

/* How many streams were there globally on 01-01-2016? */
SELECT SUM(streams) FROM plays WHERE DATE = ' 2016-01-01' ;
/* 123,913,531*/ 

/*How many times was track_id 150jeu5D3FxAmv3f7tc9h9 streamed in total?*/
SELECT plays.track_id ,SUM(streams) FROM plays WHERE track_id='150jeu5D3FxAmv3f7tc9h9' ; 
/* 6,611,284 */ 
/*Please write a SQL “WHERE” statement to link the tables “artists” and “tracks” with the goal of listing each artist and all associated track names*/ 
WHERE artists.id = tracks.artist_id 

/* Please give the Track ID of all tracks by “Racoon” that are present in the charts. */ 
SELECT artists.name ,tracks.id FROM artists ,tracks WHERE artists.id =tracks.artist_id AND artists.name='Racoon' ;

/* When left joining tracks with echonest (imposing a limit of 100), how many rows do not have a corresponding match*/

SELECT * FROM tracks LEFT JOIN echonest ON tracks.id=echonest.id LIMIT 100;

/* Please compile a list of all songs released by Ed Sheeran (Ed Sheeran’s artist id is 7); how many of those have data available at EchoNest? */
SELECT * FROM tracks LEFT JOIN artists ON artists.id=tracks.artist_id LEFT JOIN echonest ON artists.id=echonest.id WHERE artists.name="Ed sheeran" ;
