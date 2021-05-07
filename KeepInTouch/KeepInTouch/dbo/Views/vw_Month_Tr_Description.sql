
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Month transposed - WORK FILE

CREATE VIEW [dbo].[vw_Month_Tr_Description]
AS

	------------------------------------------
	SELECT
	[PersonID],[Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec]
	
	FROM (
	  SELECT [PersonID],[Month], [Description]
	  FROM [vw_Month_All] 
	) AS src

	PIVOT(
		MAX([Description])
		FOR [Month]
		IN ([Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec])
	) AS PVTTable
	------------------------------------------

