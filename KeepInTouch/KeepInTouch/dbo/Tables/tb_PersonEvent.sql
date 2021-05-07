CREATE TABLE [dbo].[tb_PersonEvent] (
    [PersonEventID] INT IDENTITY (1, 1) NOT NULL,
    [PersonID]      INT NOT NULL,
    [EventID]       INT NOT NULL,
    [Selected]      BIT NOT NULL,
    CONSTRAINT [PK_tb_PersonEvent] PRIMARY KEY CLUSTERED ([PersonEventID] ASC),
    CONSTRAINT [FK_tb_PersonEvent_tb_Event] FOREIGN KEY ([EventID]) REFERENCES [dbo].[tb_Event] ([EventID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_tb_PersonEvent_tb_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After new record create in [tb_PersonEvent]
-- Create corresponding new record in [tb_PersonMonth]
-- Edit allowed only if all current year events have been updated

CREATE TRIGGER [dbo].[tr_PersonEventUPDATE]
   ON [dbo].tb_PersonEvent
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------Check if allow edit or not
	DECLARE @Count int;

	EXEC [dbo].[sp_CurrentYearADD]
	
	SELECT @Count = count(*)
	FROM [dbo].[vw_EventsThisYear_Incomplete]
	WHERE Day IS NULL OR Month IS NULL;

	---------------------------------------------------Not allowd
	IF @Count > 0
		BEGIN
			RAISERROR ('FINALIZE CURRENT YEAR EVENTS BEFORE EDITING', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN 
		END
	---------------------------------------------------Allowed
	IF @Count = 0
		BEGIN
	
		DECLARE @PersonID as int;
		DECLARE @Reference as int;
		DECLARE @Selected as binary;

			SELECT @PersonID = PersonID, @Reference = EventID, @Selected = Selected FROM inserted;

			IF @Selected = 1
				BEGIN
				EXEC [dbo].[sp_PersonMonthUPDATE]@PersonID,1,@Reference,0,1; -- [tb_PersonMonth] ADD NEW
				END
			ELSE
				BEGIN
				EXEC [dbo].[sp_PersonMonthUPDATE]@PersonID,1,@Reference,0,0; --[tb_PersonMonth] DELETE OLD
				END

	END
	---------------------------------------------------
END
