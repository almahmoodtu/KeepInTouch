
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- FOR EXPORT - CSV FOR GOOGLE CALENDER
-- MONTHLY REMINDERS & ANNUAL EVENTS (take place at 1PM-2PM)

CREATE PROCEDURE [dbo].[sp_Z_Export_Google2]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	--PREPARATION
	--------------------------------------------------
		DELETE FROM tb_Z_Export_Google2;

	--------------------------------------------------
	--ANNUAL EVENTS
	--------------------------------------------------

		CREATE TABLE #Temp_Table1 (EventID INT, People NVARCHAR(MAX));

		;WITH x AS
		(
		  SELECT EventID, Relation, Name FROM vw_Event_Selected GROUP BY EventID, Relation, Name
		),
		y AS
		(
		  SELECT x.EventID, x.Relation, Name = STRING_AGG(x.Name,', ') WITHIN GROUP (ORDER BY Name) 
		  FROM x GROUP BY EventID, Relation
		)
		INSERT INTO #Temp_Table1
		SELECT y.EventID, y.Relation + ': ' + CHAR(10) + y.Name + '.'
		  FROM y
		  GROUP BY y.EventID, y.Relation, y.Name;

		---PART 2
		CREATE TABLE #Temp_Table2 (EventID INT, People NVARCHAR(MAX));

		;WITH x AS
		(
		  SELECT EventID, People FROM #Temp_Table1 GROUP BY EventID, People
		),
		y AS
		(
		  SELECT x.EventID, People = STRING_AGG(x.People, CHAR(10)+' | '+CHAR(10)) WITHIN GROUP (ORDER BY People) 
		  FROM x GROUP BY EventID
		)
		INSERT INTO #Temp_Table2
		SELECT y.EventID, y.People
		  FROM y
		  GROUP BY y.EventID, y.People;

		--PART 3
		INSERT INTO tb_Z_Export_Google2
		SELECT 
			'KeepInTouch | ' + ETY.Event AS 'Subject',
			CONVERT(varchar(2),ETY.Month) + '/' + CONVERT(varchar(2),ETY.Day) + '/' + CONVERT(varchar(4),ETY.Year) AS 'Start Date',
			'1:00:00 PM' AS 'Start Time',
			CONVERT(varchar(2),ETY.Month) + '/' + CONVERT(varchar(2),ETY.Day) + '/' + CONVERT(varchar(4),ETY.Year) AS 'End Date',
			'2:00:00 PM' AS 'End Time',
			T.People AS 'Description'
		FROM #Temp_Table2 AS T
			INNER JOIN vw_EventsThisYear_All AS ETY
			ON T.EventID = ETY.EventID;


	--------------------------------------------------
	--MONTHLY REMINDERS
	--------------------------------------------------

		CREATE TABLE #Temp_Table3 (MonthID INT, Month NVARCHAR(3), People NVARCHAR(MAX));

		;WITH x AS
		(
		  SELECT MonthID, Month, Relation, Name FROM vw_Month_Filled GROUP BY MonthID, Month, Relation, Name
		),
		y AS
		(
		  SELECT x.MonthID, x.Month, x.Relation, Name = STRING_AGG(x.Name,', ') WITHIN GROUP (ORDER BY Name) 
		  FROM x GROUP BY MonthID, Month, Relation
		)
		INSERT INTO #Temp_Table3
		SELECT y.MonthID, y.Month, y.Relation + ': ' + CHAR(10) + y.Name
		  FROM y
		  GROUP BY y.MonthID, y.Month, y.Relation, y.Name;

		---PART 2
		CREATE TABLE #Temp_Table4 (MonthID INT, Month NVARCHAR(3), People NVARCHAR(MAX));

		;WITH x AS
		(
		  SELECT MonthID, Month, People FROM #Temp_Table3 GROUP BY MonthID, Month, People
		),
		y AS
		(
		  SELECT x.MonthID, x.Month, People = STRING_AGG(x.People, CHAR(10)+' | '+CHAR(10)) WITHIN GROUP (ORDER BY People) 
		  FROM x GROUP BY MonthID, Month
		)
		INSERT INTO #Temp_Table4
		SELECT y.MonthID, y.Month, y.People
		  FROM y
		  GROUP BY y.MonthID, y.Month, y.People;

		---PART 3
		INSERT INTO tb_Z_Export_Google2
		SELECT
			'KeepInTouch | ' + Month AS 'Subject',
			[dbo].[sf_GetFirstSunday](MonthID) AS 'Start Date',
			'1:00:00 PM' AS 'Start Time',
			[dbo].[sf_GetFirstSunday](MonthID) AS 'End Date',
			'2:00:00 PM' AS 'End Time',
			People AS 'Description'
		FROM #Temp_Table4;

		DROP TABLE #Temp_Table1;
		DROP TABLE #Temp_Table2;
		DROP TABLE #Temp_Table3;
		DROP TABLE #Temp_Table4;
	--------------------------------------------------

END
