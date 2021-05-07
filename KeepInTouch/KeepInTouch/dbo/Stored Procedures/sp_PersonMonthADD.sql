
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonMonth
-- ADD NEW RECORDS based on tb_Person, tb_Month
------------------ triggered by INSERT in tb_Person, tb_Month

CREATE PROCEDURE [dbo].[sp_PersonMonthADD]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	INSERT INTO tb_PersonMonth (PersonID, MonthID)

	SELECT P.PersonID, M.MonthID
	FROM tb_Person AS P
	CROSS JOIN tb_Month AS M

	WHERE NOT EXISTS (
		SELECT PM.PersonID, PM.MonthID
		FROM tb_PersonMonth AS PM
		WHERE PM.PersonID = P.PersonID AND PM.MonthID = M.MonthID
		);
	--------------------------------------------------

END
