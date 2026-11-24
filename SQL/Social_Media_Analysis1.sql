USE social_media_analysis;

-- TASK 1: Count Total Posts
SELECT COUNT(*) AS total_posts
FROM social_posts;

-- DATASET EXPLORATION
SELECT * FROM social_posts LIMIT 10;

DESC social_posts;

-- TASK 2: Average Likes Per Post
SELECT ROUND(AVG(likes_count), 2) AS average_likes FROM social_posts;

-- TASK 3: Top 10 Most Engaged Posts
SELECT post_id, platform, likes_count, comments_count,
shares_count, (likes_count + comments_count + shares_count)
AS total_engagement FROM social_posts ORDER BY total_engagement DESC
LIMIT 10;

-- TASK 4: ANALYZE ENGAGEMENT BY PLATFORM
SELECT platform, SUM(likes_count) AS total_likes, SUM(comments_count) AS total_comments,
SUM(shares_count) AS total_shares, SUM(likes_count + comments_count + shares_count) AS total_engagement
FROM social_posts GROUP BY platform ORDER BY total_engagement DESC;

-- TASK 5: ANALYZE MONTHLY POSTING TRENDS
SELECT DATE_FORMAT(timestamp, '%Y-%m') AS post_month, COUNT(*) AS total_posts
FROM social_posts GROUP BY DATE_FORMAT(timestamp, '%Y-%m') ORDER BY post_month;

-- TASK 6: CALCULATE AVERAGE COMMENTS PER POST
SELECT ROUND(AVG(comments_count), 2) AS average_comments FROM social_posts;

-- TASK 7: FIND POSTS WITH HIGHEST IMPRESSIONS
SELECT post_id, platform, impressions, likes_count, comments_count, shares_count
FROM social_posts ORDER BY impressions DESC LIMIT 10;

-- TASK 8: RANK POSTS BASED ON ENGAGEMENT
SELECT post_id, platform, likes_count, comments_count, shares_count,
(likes_count + comments_count + shares_count) AS total_engagement,
RANK() OVER (ORDER BY(likes_count + comments_count + shares_count) DESC) AS engagement_rank
FROM social_posts;

-- TASK 9: ANALYZE HASHTAG USAGE
SELECT post_id, platform, hashtags
FROM social_posts LIMIT 10;

WITH RECURSIVE hashtag_split AS (SELECT TRIM(SUBSTRING_INDEX(hashtags, ',', 1)) AS hashtag, CASE
WHEN hashtags LIKE '%,%' THEN SUBSTRING(hashtags, LOCATE(',', hashtags) + 1) ELSE NULL
END AS remaining FROM social_posts WHERE hashtags IS NOT NULL AND TRIM(hashtags) <> ''
UNION ALL
SELECT TRIM(SUBSTRING_INDEX(remaining, ',', 1)), CASE WHEN remaining LIKE '%,%'
THEN SUBSTRING(remaining, LOCATE(',', remaining) + 1) ELSE NULL
END
FROM hashtag_split WHERE remaining IS NOT NULL
)
SELECT LOWER(hashtag) AS hashtag, COUNT(*) AS usage_count FROM hashtag_split
WHERE hashtag <> '' GROUP BY LOWER(hashtag) ORDER BY usage_count DESC LIMIT 10;

-- TASK 10: CALCULATE ENGAGEMENT RATE
SELECT post_id, platform, likes_count, comments_count, shares_count, impressions, ROUND(
(likes_count + comments_count + shares_count) / NULLIF(impressions, 0) * 100, 2
) AS calculated_engagement_rate FROM social_posts;

