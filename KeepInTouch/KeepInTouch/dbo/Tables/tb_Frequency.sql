CREATE TABLE [dbo].[tb_Frequency] (
    [FrequencyID]   INT           IDENTITY (1, 1) NOT NULL,
    [Frequency]     NVARCHAR (50) NOT NULL,
    [MonthsPerYear] INT           NOT NULL,
    CONSTRAINT [PK_tb_Frequency] PRIMARY KEY CLUSTERED ([FrequencyID] ASC)
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- Block delete
-- tb_Frequency

CREATE TRIGGER tr_FrequencyDELETE
   ON tb_Frequency
   INSTEAD OF DELETE
AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------
	RAISERROR ('DELETING RECORDS IS NOT PERMITTED.', 16, 1);
	--------------------------------------------

END
