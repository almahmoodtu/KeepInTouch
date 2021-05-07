
-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get all Anniversaries

CREATE FUNCTION [dbo].[tf_Anniversaries]  () 

RETURNS TABLE 
AS
RETURN 
(

	------------------------------------------
	SELECT
		PA.PersonAnniversaryID,
		PA.PersonID,
		PA.AnniversaryID,
		A.Anniversary,
		PA.Day,
		PA.Month,
		PA.Year,
		[dbo].[sf_CalculateAge](PA.Year) AS Age

	FROM
		dbo.tb_PersonAnniversary AS PA
		INNER JOIN dbo.tb_Anniversary AS A
			ON PA.AnniversaryID = A.AnniversaryID	
	------------------------------------------

)
