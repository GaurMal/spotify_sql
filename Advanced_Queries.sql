/*
----------------------------
Advanced Category Question
----------------------------


1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
4. Find tracks where the energy-to-liveness ratio is greater than 1.2.
5. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/

-- Q1. Find the top 3 most-viewed tracks for each artist using window functions.

-- each artist and total view for each track
-- track with the highest view for each artist 
-- DenseRank
-- cte and filter rank <= 3

With ranked_artist
As 
(Select 
	artist, 
	track, 
	Sum(views) as total_views,
	Dense_Rank() over(partition by artist Order By Sum(views) Desc) as Rank 
from Spotify
Group By artist, track
Order By artist, Sum(views) desc
)
Select * from ranked_artist
Where Rank <= 3

--Q2. Write a query to find tracks where the liveness score is above the average.

Select track, liveness
from spotify
Where liveness > (Select Avg(liveness) from spotify)

-- Q3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

With cte
as
(Select 
	album, 
	Max(energy) as high_energy,
	Min(energy) as low_energy
from spotify
Group By album
)
select album, high_energy-low_energy as energy_diff
from cte
Order By energy_diff desc

-- Q4. Find tracks where the energy-to-liveness ratio is greater than 1.2.

Select track, artist, energy, liveness, (energy/liveness) as energy_to_liveness_ratio
from spotify
Where (energy/liveness) > 1.2


-- Q5. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

Select track, artist, views, likes, sum(likes) Over (Order By views Desc) as cumulative_likes
from spotify
Order By views Desc
Limit 10