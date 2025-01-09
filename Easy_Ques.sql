/*
-------------------------
Easy Category Question
-------------------------

1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where licensed = TRUE.
4. Find all tracks that belong to the album type single.
5. Count the total number of tracks by each artist.
*/

-- Q1. Retrieve the names of all tracks that have more than 1 billion streams.

Select track, stream from spotify
Where stream > 1000000000


-- Q2. List all albums along with their respective artists.

Select album, artist from spotify    -- Total rows: 20592

-- Some albums can have more than artists

Select Distinct album, artist from spotify -- Total rows: 14178

-- Q3. Get the total number of comments for tracks where licensed = TRUE.

Select Sum(comments) as Total_comments 
from spotify
Where licensed = 'true'

-- Q4. Find all tracks that belong to the album type single.

Select * from spotify 
Where album_type = 'single'

-- Q5. Count the total number of tracks by each artist.

Select artist, count(*) as total_no_songs
from spotify
Group By artist
Order By total_no_songs
