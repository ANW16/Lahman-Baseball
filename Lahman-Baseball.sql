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
ORDER BY total_salary DESC*/


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

/*SELECT batting.yearid, CONCAT(namefirst, ' ', namelast) AS name, sb, cs, ROUND(sb/(sb+cs)::decimal, 2) AS success_rate
FROM batting INNER JOIN people ON batting.playerid = people.playerid
WHERE sb + cs >= 20 AND yearid = '2016'
ORDER BY success_rate DESC*/


			---1970-2016 WS Data---

WITH all_time_wins AS (SELECT DISTINCT(teamid), SUM(w) total_wins
						FROM teams
						WHERE yearid >= 1970 
						GROUP BY teamid
						ORDER BY total_wins DESC),
			
			ws_losers AS (SELECT yearid, teamid, wswin AS ws_loss, w
						FROM teams
						WHERE yearid >= 1970 AND wswin ILIKE 'N'
						ORDER BY yearid ASC),
						
			ws_winners AS (SELECT yearid, teamid, wswin AS ws_win, w
						FROM teams
						WHERE yearid >= 1970 AND wswin ILIKE 'Y'
						ORDER BY yearid ASC)
						
SELECT teams.yearid, MAX(w) AS most_w
FROM teams
WHERE teams.yearid >= 1970 
GROUP BY teams.yearid
ORDER BY teams.yearid ASC
						

			--Total Wins for Losers/Winners of WS--
			
/*SELECT yearid, teamid, w AS total_wins, wswin
FROM teams
WHERE yearid >= 1970 AND wswin ILIKE 'N'
GROUP BY teamid, wswin, yearid, w
ORDER BY total_wins DESC*/

/*SELECT yearid, teamid, w AS total_wins, wswin
FROM teams
WHERE yearid >= 1970 AND wswin ILIKE 'Y' AND yearid <> 1981
GROUP BY teamid, wswin, yearid, w
ORDER BY total_wins ASC*/

			---Attendance for Teams/Parks---
			
/*SELECT  park_name, franchname, (homegames.attendance / games) AS atd_avg
FROM homegames 
		LEFT JOIN parks ON homegames.park = parks.park 
		LEFT JOIN teams ON teams.teamid = homegames.team 
		LEFT JOIN teamsfranchises ON teamsfranchises.franchid = teams.franchid
WHERE year = 2016 AND games >= 10
GROUP BY franchname, park_name, games, homegames.attendance
ORDER BY atd_avg DESC*/

			
			
			
			
			---Manager of the year AL & NL---
			
/*WITH TSN_winners AS (SELECT *
					FROM awardsmanagers
					WHERE awardid ILIKE 'TSN Manager of the Year'),
					
		nl_winners AS (SELECT *
					FROM TSN_winners
					WHERE lgid ILIKE 'NL'),
					
		al_winners AS (SELECT *
					FROM TSN_winners
					WHERE lgid ILIKE 'AL'),
					
		alnl_winners AS (SELECT nl_winners.playerid, al_winners.lgid AS al_win, al_winners.yearid AS al_year, nl_winners.lgid AS nl_win, nl_winners.yearid AS nl_year
					FROM al_winners INNER JOIN nl_winners ON al_winners.playerid = nl_winners.playerid)
					
SELECT alnl_winners.playerid, CONCAT(namefirst, ' ', namelast), teamid, al_win, al_year, nl_win, nl_year
FROM alnl_winners
FULL JOIN people ON alnl_winners.playerid = people.playerid
FULL JOIN managershalf ON alnl_winners.playerid = managershalf.playerid
WHERE people.playerid = alnl_winners.playerid*/
					
					
					
					
					
					
					
/*SELECT DISTINCT(al_nl_winners.playerid), CONCAT(namefirst, ' ', namelast), teams.teamid
FROM al_nl_winners
INNER JOIN people ON al_nl_winners.playerid = people.playerid
LEFT JOIN managershalf ON al_nl_winners.playerid = managershalf.playerid
LEFT JOIN teams ON managershalf.teamid = teams.teamid*/