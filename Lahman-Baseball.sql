			---RANGE OF YEARS---
			
/*SELECT MIN(yearid), MAX(yearid), (MAX(yearid) - MIN(yearid)) AS total_years
FROM teams*/


			---SMALLEST PLAYER---
			
/*WITH smallest_player AS (SELECT playerid, namegiven, height
							FROM people
							ORDER BY height ASC
							Limit 1)
SELECT teamid, namegiven, height, appearances.playerid
FROM appearances FULL JOIN smallest_player ON appearances.playerid = smallest_player.playerid
WHERE appearances.playerid = smallest_player.playerid*/


			---Vanderbilt University---
			
/*WITH vandy_players AS (SELECT DISTINCT(playerid)
						FROM collegeplaying
						WHERE schoolid ILIKE 'vandy'),
						
	vandy_majors AS (SELECT people.playerid, CONCAT(namefirst, ' ', namelast) AS full_name
					FROM people INNER JOIN vandy_players ON people.playerid = vandy_players.playerid)
					
SELECT vandy_majors.playerid, full_name, SUM(salary) AS total_salary
FROM salaries INNER JOIN vandy_majors ON salaries.playerid = vandy_majors.playerid
GROUP BY full_name, vandy_majors.playerid
ORDER BY total_salary DESC */


			---Putouts by Group---
			
/*SELECT yearid, SUM(po) AS total_putouts, 
CASE
	WHEN pos ILIKE 'OF' THEN 'Outfield'
	WHEN pos ILIKE 'SS' THEN 'Infield'
	WHEN pos ILIKE '1B' THEN 'Infield'
	WHEN pos ILIKE '2B' THEN 'Infield'
	WHEN pos ILIKE '3B' THEN 'Infield'
	WHEN pos ILIKE 'P'  THEN 'Battery'
	WHEN pos ILIKE 'C'  THEN 'Battery'
	ELSE pos
END AS field_pos
FROM fielding
WHERE yearid = '2016'
GROUP BY yearid, field_pos
ORDER BY total_putouts DESC*/


			---AVG Strike Outs and Home Runs per Decade---

/*SELECT yearid, teamid, g, so
FROM batting
WHERE yearid = 1920
*/


			---Base Stealing Success 2016---

/*SELECT fielding.yearid, CONCAT(namefirst, ' ', namelast) AS name, sb, cs, sb/(sb+cs)::FLOAT AS success_rate
FROM fielding INNER JOIN people ON fielding.playerid = people.playerid
WHERE sb + cs > 20 AND yearid = '2016'
ORDER BY success_rate DESC*/


			---1970-2016 WC Data---

WITH all_time_wins AS (SELECT DISTINCT(teamid), SUM(w) total_wins
						FROM teams
						WHERE yearid >= 1970 
						GROUP BY teamid
						ORDER BY total_wins DESC),
			
			ws_losers AS (SELECT teamid, wswin
						FROM teams
						WHERE yearid >= 1970 AND wswin ILIKE 'N'
						ORDER BY teamid ASC),
						
			ws_winners AS (SELECT teamid, wswin
						FROM teams
						WHERE yearid >= 1970 AND wswin ILIKE 'Y'
						ORDER BY teamid ASC),
						
	most_wins_per_season AS (SELECT DISTINCT(yearid),MAX(w)
							FROM teams
							WHERE yearid >= 1970 
							GROUP BY yearid
							ORDER BY yearid ASC)


			--Total Wins for Losers/Winners of WS--
			
/*SELECT yearid, teamid, SUM(w) AS total_wins, wswin
FROM teams
WHERE yearid >= 1970 AND wswin ILIKE 'Y'
GROUP BY teamid, wswin, yearid
ORDER BY total_wins ASC*/









