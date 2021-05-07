
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonEvent
-- ADD NEW RECORDS based on tb_Person, tb_Event
------------------ triggered by INSERT in tb_Person, tb_Event

CREATE PROCEDURE [dbo].[sp_PersonEventADD]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	INSERT INTO tb_PersonEvent (PersonID,EventID,Selected)

	SELECT P.PersonID, E.EventID, 0
	FROM tb_Person AS P
	CROSS JOIN tb_Event AS E

	WHERE NOT EXISTS (
		SELECT PE.PersonID, PE.EventID
		FROM tb_PersonEvent AS PE
		WHERE PE.PersonID = P.PersonID AND PE.EventID = E.EventID
		)
	---------------------------------------------------
END
