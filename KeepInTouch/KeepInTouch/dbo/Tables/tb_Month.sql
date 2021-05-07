CREATE TABLE [dbo].[tb_Month] (
    [MonthID] INT          IDENTITY (1, 1) NOT NULL,
    [Month]   NVARCHAR (3) NOT NULL,
    CONSTRAINT [PK_tb_Month] PRIMARY KEY CLUSTERED ([MonthID] ASC)
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- Block delete
-- tb_Month

CREATE TRIGGER tr_MonthDELETE
   ON tb_Month
   INSTEAD OF DELETE
AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------
	RAISERROR ('DELETING RECORDS IS NOT PERMITTED.', 16, 1);
	--------------------------------------------

END

GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After new record create in [tb_Month]
-- Create corresponding new record in [tb_PersonMonth]

CREATE TRIGGER [dbo].[tr_MonthINSERT]
   ON [dbo].[tb_Month] 
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------[tb_PersonMonth]
	EXEC [dbo].[sp_PersonMonthADD];
	---------------------------------------------------
END
