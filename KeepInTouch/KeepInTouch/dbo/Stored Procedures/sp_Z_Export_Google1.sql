
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- FOR EXPORT - CSV FOR GOOGLE CALENDER
-- ANNIVERSARIES (all day events)

CREATE PROCEDURE [dbo].[sp_Z_Export_Google1]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	--PREPARATION
	--------------------------------------------------
		DELETE FROM tb_Z_Export_Google1;

	--------------------------------------------------
	--ANNIVERSARIES
	--------------------------------------------------
		INSERT INTO tb_Z_Export_Google1
		
		SELECT
			'KeepInTouch | ' + Name + ' - ' + Anniversary AS 'Subject',
			CONVERT(varchar(2),Month) + '/' + CONVERT(varchar(2),Day) + '/' + CONVERT(varchar(4),YEAR(GETDATE())) AS 'Start Date',
			CONVERT(varchar(2),Month) + '/' + CONVERT(varchar(2),Day) + '/' + CONVERT(varchar(4),YEAR(GETDATE())) AS 'End Date',
			'TRUE' AS 'All Day Event',
			CASE
				WHEN Year IS NULL
				THEN Relation + '. ' + Anniversary + ' on ' + CONVERT(varchar(2),Day) + '/' + CONVERT(varchar(2),Month) + '/' + CONVERT(varchar(4),YEAR(GETDATE())) + '.'
				ELSE Relation + '. ' + CONVERT(varchar(2),Age) + ' years on ' + CONVERT(varchar(2),Day) + '/' + CONVERT(varchar(2),Month) + '/' + CONVERT(varchar(4),YEAR(GETDATE())) + '.'
				END AS 'Description'

		FROM vw_Anniversary_All;
	--------------------------------------------------

END
