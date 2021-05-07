CREATE TABLE [dbo].[tb_Event] (
    [EventID] INT           IDENTITY (1, 1) NOT NULL,
    [Event]   NVARCHAR (50) NOT NULL,
    [Day]     INT           NULL,
    [Month]   INT           NULL,
    [Fixed]   BIT           NOT NULL,
    CONSTRAINT [PK_tb_Event] PRIMARY KEY CLUSTERED ([EventID] ASC)
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After new record create in [tb_Event]
-- Create corresponding new record in [tb_YearEvent] AND [tb_PersonEvent]

CREATE TRIGGER [dbo].[tr_EventINSERT]
   ON [dbo].[tb_Event] 
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------[tb_YearEvent]
	EXEC [dbo].[sp_YearEventADD];
	---------------------------------------------------[tb_PersonEvent]
	EXEC [dbo].[sp_PersonEventADD];
	---------------------------------------------------
END

GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After record EDITED in [tb_Event]
-- Update corresponding new record in [tb_YearEvent]
-- ONLY FOR current year records

CREATE TRIGGER [dbo].[tr_EventUPDATE]
   ON [dbo].[tb_Event] 
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------[tb_YearEvent]
	EXEC [dbo].[sp_YearEventUPDATE];
	---------------------------------------------------
END

GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After record EDITED in [tb_Event]
-- Alow ONLY SPECIFIC COMBINATIONS of fields - Day, Month, Fixed

CREATE TRIGGER [dbo].[tr_EventUPDATE_Combination]
   ON [dbo].[tb_Event] 
   FOR INSERT, UPDATE
AS 

	SET NOCOUNT ON;

	---------------------------------------------------
	DECLARE @E_EventID int;
	DECLARE @E_Fixed int;
	DECLARE @E_Day int;
	DECLARE @E_Month int;

	---------------------------------------------------
	SELECT @E_EventID = EventID FROM inserted;
	SELECT @E_Fixed = Fixed FROM inserted;
	SELECT @E_Day = Day FROM inserted;
	SELECT @E_Month = Month FROM inserted;

	---------------------------------------------------
	IF @E_Fixed = 1 AND (@E_Day IS NULL OR @E_Month IS NULL)
		-- Fixed, but date not entered
		-- Must enter date
		-- Or review record
	BEGIN
		RAISERROR ('FIXED = 1 BUT (DAY, MONTH) IS NULL', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN 
	END

	---------------------------------------------------
	IF @E_Fixed = 0 AND (@E_Day IS NOT NULL OR @E_Month IS NOT NULL)
		-- Not fixed, but date entered
		-- Must remove data
		-- Or review record
	BEGIN
		RAISERROR ('FIXED = 0 BUT (DAY, MONTH) IS NOT NULL', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN 
	END
	---------------------------------------------------
