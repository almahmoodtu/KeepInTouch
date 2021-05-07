
-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get first sunday of the month (of the current year)

CREATE FUNCTION [dbo].[sf_GetFirstSunday]
(
	@Month INT -->> TAKE INPUT
)

RETURNS NVARCHAR(10)
AS
BEGIN

	------------------------------------------
	DECLARE @FirstDay DATETIME, @DateMMDDYYY NVARCHAR(10);

	SET @FirstDay = CAST(CAST(@Month AS VARCHAR) + '/01/' + CAST(YEAR(GETDATE()) AS VARCHAR) AS DATETIME);

	SET @DateMMDDYYY = FORMAT (@FirstDay + ( 7 - DATEPART ( weekday , @FirstDay ) + 1 ) % 7, 'M/d/yyyy');

	RETURN @DateMMDDYYY;
	------------------------------------------

END
