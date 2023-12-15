/* Analyzing the YouTube video DATABASE to determine the most popular and appreciated content.
   This will help identify the type of YouTube videos that are likely to garner views. */

/* Finding the 20 most popular videos:
   Understanding: The most popular videos seem to include music videos and gameshows*/
SELECT v.Title, v.Views
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Title
ORDER BY v.Views DESC
LIMIT 20;

/* Finding the 20 most popular videos by likes:
   Understanding: While music videos still dominate, MrBeast videos appear more frequently among the most liked. */
SELECT v.Title, v.Likes
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Title
ORDER BY v.Likes DESC
LIMIT 20;

/* Finding the 20 most searched keywords by views:
   Understanding: Popular video keywords don't necessarily match video content.
   Notable exceptions include 'animals' (animal-related video), 'mrbeast' (gameshow videos), and 'google' (2021 recap). */
SELECT v.Keyword, v.Views
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Keyword
ORDER BY v.Views DESC
LIMIT 20;

/* Finding the 20 most searched keywords by likes:
   Understanding: Overlapping with popular video content, keywords like 'animals,' 'mrbeast,' and 'google' stand out. */
SELECT v.Keyword, v.Likes
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Keyword
ORDER BY v.Likes DESC
LIMIT 20;

/* Finding the 20 most liked comments:
   Understanding: The most liked comments appear to be either from the creator or are humorous in nature. */
SELECT c.Comment, c.Likes
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY c.Comment
ORDER BY c.Likes DESC
LIMIT 20;

/* Finding the 20 most viewed videos related to technology keywords:
   Understanding: Popular technology-related videos cover gaming, education, and Google topics. */
SELECT v.Title, v.Keyword, v.Views
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
WHERE v.Keyword IN ("data science", "minecraft", "google", "gaming", "computer science", "nintendo")
GROUP BY v.Title, v.Keyword
ORDER BY v.Views DESC
LIMIT 20;

/* Finding the view/like ratio for technology-related videos:
   Understanding: Teaching technology and gaming-related videos tend to have higher view/like ratios. */
SELECT v.Title, v.Keyword, v.Views / v.Likes AS ViewLikeRatio
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
WHERE v.Keyword IN ("data science", "minecraft", "google", "gaming", "computer science", "nintendo")
GROUP BY v.Title, v.Keyword
ORDER BY ViewLikeRatio DESC
LIMIT 20;

/* Finding the average sentiment for each video keyword:
   Understanding: Aside from music-related keywords, the highest average sentiment is associated with learning computer science videos. */
SELECT v.Keyword, AVG(c.Sentiment) AS AvgSentiment
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Keyword
ORDER BY AvgSentiment DESC
LIMIT 20;

/* Finding the average sentiment for each video:
   Understanding: Similar to the above, learning computer science videos show the highest average sentiment. */
SELECT v.Title, AVG(c.Sentiment) AS AvgSentiment
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
GROUP BY v.Title
ORDER BY AvgSentiment DESC
LIMIT 20;

/* Conclusion based on data analysis:
   The most viral videos are either music or gameshow related.
   However, based on average sentiment, videos related to learning computer and data science are most appreciated.
   While these videos may not go viral like music and gameshow videos, they have a positive impact and reception.
   Thus, creating YouTube videos related to teaching computer science and data science appears to be the most appropriate decision. */

/* Finding the highest sentiment videos between 2017-2022:
   Understanding: Learning videos were popular between 2017 and 2020. */
SELECT v.Title, DATE(v.PublishedAt) AS PublicationDate, AVG(c.Sentiment) AS AvgSentiment, v.Views
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
WHERE PublicationDate BETWEEN '2017-01-01' AND '2022-12-31'
GROUP BY PublicationDate, v.Views
ORDER BY AvgSentiment DESC
LIMIT 20;

/* Finding the highest sentiment videos between 2020-2022:
   Understanding: Learning videos remained popular between 2020 and 2022. */
SELECT v.Title, DATE(v.PublishedAt) AS PublicationDate, AVG(c.Sentiment) AS AvgSentiment, v.Views
FROM comments c
JOIN videos_stats v ON c.VideoID = v.VideoID
WHERE PublicationDate BETWEEN '2020-01-01' AND '2022-12-31'
GROUP BY PublicationDate, v.Views
ORDER BY AvgSentiment DESC
LIMIT 20;

/* Based on the above queries, machine learning within data science appears to be the most popular topic.
   Thus, creating YouTube videos related to machine learning is suggested. */