-- EDA (Exploratory Data Analyst)

select * from spotif

-- Total number of rows
Select count(*) from spotify;

-- Total unique artist
Select Count(Distinct artist) from spotify

-- All unique album type
Select Distinct album_type from spotify

-- Max and min duration of a song
Select Max(duration_min) from spotify -- 77.9343

Select Min(duration_min) from spotify -- song can be of 0 min

Select * from spotify
Where duration_min = 0 

-- 2 records found

-- To delete them
Delete from spotify
Where duration_min = 0

-- Now min duration
Select Min(duration_min) from spotify -- 0.516416667

-- Unique channel
Select Distinct channel from spotify

-- Unique most_played_on
Select Distinct most_played_on from spotify
