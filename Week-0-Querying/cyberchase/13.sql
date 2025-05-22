select title, season, episode_in_season, air_date from episodes
WHERE topic like "%one%" OR "%two%"
ORDER BY air_date;
