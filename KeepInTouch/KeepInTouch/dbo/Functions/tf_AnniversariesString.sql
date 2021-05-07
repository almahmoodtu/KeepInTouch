

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Covert anniversaries into string

CREATE FUNCTION [dbo].[tf_AnniversariesString]  
(		
	@ID int -->> TAKE INPUT
)

RETURNS TABLE 
AS
RETURN 
(
	------------------------------------------
	SELECT
		Anniversary + ' ' 
			+ CAST(Day AS varchar) 
			+ '/' + CAST(Month AS varchar) 
			+ '/' + CAST(ISNULL(Year, '') AS varchar) AS Anniversary
	FROM
		tf_Anniversaries()
	WHERE
		PersonID = @ID
	------------------------------------------
)
