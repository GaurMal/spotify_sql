/*
-------------------------
Medium Category Question
-------------------------

1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
2. List all tracks along with their views and likes where official_video = TRUE.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- Q1. Calculate the average danceability of tracks in each album.

Select album, Avg(danceability) as danceability_average
from spotify
Group By album
Order By danceability_average desc
 
--Q2. Find the top 5 tracks with the highest energy values.

Select track, Max(energy)
from spotify
Group By track
Order by Max(energy) desc
Limit 5

-- Q3. List all tracks along with their views and likes where official_video = TRUE.

Select track, Sum(views) as total_views, Sum(likes) as total_likes 
from spotify
Where official_video='true'
Group By track

-- Q4. For each album, calculate the total views of all associated tracks.

Select album, track, Sum(views) as total_views
from spotify
Group By album, track
Order By total_views desc

-- Q5. Retrieve the track names that have been streamed on Spotify more than YouTube.

Select * 
from
	(Select 
		track, 
		-- most_played_on, 
		COALESCE(Sum(Case When most_played_on = 'Youtube' Then stream END),0) as youtube_stream,
		COALESCE(Sum(Case When most_played_on = 'Spotify' Then stream END),0) as spotify_stream
	from spotify 
	Group By track
	) as tbl1
Where spotify_stream > youtube_stream and youtube_stream <> 0
