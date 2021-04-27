			---RANGE OF YEARS---
			
/*SELECT MIN(yearid), MAX(yearid), (MAX(yearid) - MIN(yearid)) AS total_years
FROM appearances*/


			---SMALLEST PLAYER---
			
/*WITH smallest_player AS (SELECT playerid, namegiven, height
							FROM people
							ORDER BY height ASC
							Limit 1)
SELECT yearid, teamid, appearances.playerid
FROM appearances FULL JOIN smallest_player ON appearances.playerid = smallest_player.playerid
WHERE appearances.playerid = smallest_player.playerid*/


			---Vanderbilt University---
			
/*WITH vandy_players AS (SELECT DISTINCT(playerid)
						FROM collegeplaying
						WHERE schoolid ILIKE 'vandy'),
						
	vandy_majors AS (SELECT people.playerid, namegiven
					FROM people INNER JOIN vandy_players ON people.playerid = vandy_players.playerid)
					
SELECT vandy_majors.playerid, namegiven, SUM(salary) AS total_salary
FROM salaries INNER JOIN vandy_majors ON salaries.playerid = vandy_majors.playerid
GROUP BY namegiven, vandy_majors.playerid
ORDER BY total_salary DESC */









