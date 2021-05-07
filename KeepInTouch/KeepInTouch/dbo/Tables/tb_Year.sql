CREATE TABLE [dbo].[tb_Year] (
    [YearID] INT IDENTITY (1, 1) NOT NULL,
    [Year]   INT NOT NULL,
    CONSTRAINT [PK_tb_Year] PRIMARY KEY CLUSTERED ([YearID] ASC)
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After new record created in [tb_Year]
-- Add corresponding to [tb_YearEvent]

CREATE TRIGGER [dbo].[tr_YearINSERT]
   ON [dbo].[tb_Year] 
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------
	EXEC [dbo].[sp_YearEventADD];
	---------------------------------------------------
END
