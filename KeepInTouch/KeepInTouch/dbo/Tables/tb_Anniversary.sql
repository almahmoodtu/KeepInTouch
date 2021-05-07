CREATE TABLE [dbo].[tb_Anniversary] (
    [AnniversaryID] INT           IDENTITY (1, 1) NOT NULL,
    [Anniversary]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_tb_Anniversary] PRIMARY KEY CLUSTERED ([AnniversaryID] ASC)
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- Block delete
-- tb_Anniversary

CREATE TRIGGER tr_AnniversaryDELETE
   ON tb_Anniversary
   INSTEAD OF DELETE
AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------
	RAISERROR ('DELETING RECORDS IS NOT PERMITTED.', 16, 1);
	--------------------------------------------
END
