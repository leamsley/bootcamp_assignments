WEEK 5 WORKSHOP | ONLINE MUSIC STORE

-- 1. Basic Selection:

SELECT title, release_date
FROM songs
WHERE release_date LIKE '2022%';


-- 2. Filtering:

SELECT title, duration_seconds, popularity_score
FROM songs
WHERE popularity_score > 80 AND duration_seconds < 240;


-- 3. Pattern Matching:

SELECT artist_name
FROM artists
WHERE artist_name LIKE 'The%';


-- 4. Multiple Conditions

SELECT first_name, last_name, join_date, premium_member
FROM customers
WHERE premium_member = 'true' AND join_date LIKE '2022%';


-- 5. Calculations + Aliasing

SELECT SUM(duration_seconds) AS duration_sum
FROM songs;

-- 6. Advanced Filtering

SELECT song_id, price
FROM purchases
ORDER BY price DESC
LIMIT 5;

-- 7. Using Multiple Tables Separately:

SELECT songs.song_id, songs.popularity_score, purchases.purchase_id
FROM songs
LEFT JOIN purchases
ON songs.song_id = purchases.song_id
WHERE songs.popularity_score > 90;


-- 8. Range Checking:

SELECT purchase_id, purchase_date
FROM purchases
WHERE purchase_date BETWEEN '2023-01-01' AND '2023-03-31'
ORDER BY purchase_date ASC;


-- 9. Advanced Filtering with ORDER BY

SELECT artists.artist_name, songs.title, songs.popularity_score
FROM songs
LEFT JOIN artists
ON songs.artist_id = artists.artist_id
WHERE songs.popularity_score > 90
ORDER BY songs.popularity_score DESC;


---------------------------------------------

Discussion Questions:

1. Having two separate tables is beneficial because a stream doesn't equal a purchase. You can track revenue and engagement individually.

2. Some ideas for business questions:
	a. What artist has the most streamed songs?
	b. What song has made the most revenue?
	c. How does the premium membership affect the number of songs purchased?
	d. What are the best performing genres in terms of streams and revenue?

3. I would extend it to include:
	a. Duration (in seconds) of time listened for each song (integer)
	b. Song skipped (boolean)

4. 

SELECT
artists.artist_name,
songs.title,
songs.duration_seconds,
songs.popularity_score
FROM songs
LEFT JOIN artists
ON songs.artist_id = artists.artist_id
WHERE songs.popularity_score > 80
AND songs.duration_seconds < 240
AND artists.artist_name LIKE 'The%';



