
------------------------------------
-- Exploratory Queries
------------------------------------

-- count of data meeting specific criteria: number of games
SELECT
    COUNT(app_id) AS total_games
FROM steam_data;
-- 2839

-- identification of minimum/maximum values
SELECT
	MIN(owner_count_average) AS lowest_ownership,
	MAX(owner_count_average) AS highest_ownership
FROM steam_data;
-- 75000,150000000

-- finding all games with the word "Gun"
SELECT
    game_title
FROM steam_data
WHERE game_title LIKE '%Gun%'
ORDER BY game_title ASC;
-- Enter the Gungeon
-- GUN
-- GUNS UP!
-- Gal*Gun: Double Peace
-- GunZ 2: The Second Duel

-- subquery to find an example where the publisher and developer are different
SELECT
	game_title,
	developer,
	publisher
FROM steam_data
WHERE (developer, publisher) = (
	SELECT developer, publisher
	FROM steam_data
	WHERE publisher = 'Square Enix'
);
-- Hitman: Sniper Challenge,IO Interactive,Square Enix
-- Kane & Lynch 2: Dog Days,IO Interactive,Square Enix

------------------------------------
-- BUSINESS QUERIES
------------------------------------

-- find games with an average owner count over 7,500,000 and provide each game's total revenue
SELECT
    game_title,
    SUM(revenue) as total_revenue,
    AVG(owner_count_average) as average_owners
FROM steam_data
WHERE owner_count_average >= 7500000
GROUP BY game_title
ORDER BY average_owners;
-- Dota 2,0,150000000
-- PLAYERUNKNOWN'S BATTLEGROUNDS,2249250000,75000000
-- Counter-Strike: Global Offensive,0,75000000
-- Warframe,0,35000000
-- Unturned,0,35000000

-- find the average revenue associated with each game genre
SELECT
    genre,
    ROUND(AVG(revenue),2) as average_revenue
FROM steam_data
GROUP BY genre
ORDER BY average_revenue DESC;
-- MMO,16303711.17
-- RPG,12699683.48
-- Simulation,11635933.33
-- Action Adventure,11450387.35

-- rank games in each genre that earn more than $100,000 in revenue
SELECT
	game_title,
	genre,
	revenue,
	RANK() OVER (
	PARTITION BY genre
	ORDER BY revenue DESC
) AS dense_rank
FROM steam_data
WHERE revenue > 100000;
-- Action Adventure,449925000,1
-- Action Adventure,449850000,2
-- Action Adventure,296925000,3
-- Action Adventure,209965000,4
-- Action Adventure,209965000,4

-- find distinct developers that contain adult content and have more than $100,000 in total revenue
-- BUT they have fewer than 100 positive reviews
SELECT
    DISTINCT(developer),
    revenue,
    genre,
    positive_reviews
FROM steam_data
WHERE adult_content_check = 'TRUE' AND revenue > 100000 AND positive_reviews < 100
ORDER BY genre ASC
LIMIT 100;
-- Fazan,1124250,Action Adventure,59
-- "Arcen Games, LLC",749250,Action Adventure,29
-- Skobbejak Games,749250,Action Adventure,59
-- From Soy Sauce LLC,449250,Action Adventure,79
-- XeniosVision,374250,Action Adventure,43

-- filtering to find the best performing developers
SELECT
    developer,
    ROUND(AVG(owner_count_average), 2) as average_owners
FROM steam_data
WHERE owner_count_average > 2000000 AND developer IS NOT NULL
GROUP BY developer
ORDER BY average_owners DESC
LIMIT 50;
-- "Valve, Hidden Path Entertainment",75000000
-- PUBG Corporation,75000000
-- Smartly Dressed Games,35000000
-- Digital Extremes,35000000
-- Valve,17478260.87

-- filtering to find the best performing publishers
SELECT
    publisher,
    ROUND(AVG(owner_count_average), 2) as average_owners
FROM steam_data
WHERE owner_count_average > 2000000 AND publisher IS NOT NULL
GROUP BY publisher
ORDER BY average_owners DESC
LIMIT 50;
-- PUBG Corporation,75000000
-- Smartly Dressed Games,35000000
-- Digital Extremes,35000000
-- Valve,18777777.78
-- Starbreeze Publishing AB,15000000

-- what percentage of games are free
SELECT
    ROUND(
        (SELECT
             COUNT(*)
         FROM steam_data
         WHERE price = 0) * 100.0
            / COUNT(*),
            2
        ) AS percentage_free_games
FROM steam_data;
-- 23

