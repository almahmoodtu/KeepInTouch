CREATE TABLE [dbo].[tb_PersonMonth] (
    [PersonMonthID] INT            IDENTITY (1, 1) NOT NULL,
    [PersonID]      INT            NOT NULL,
    [MonthID]       INT            NOT NULL,
    [Description]   NVARCHAR (500) NULL,
    CONSTRAINT [PK_tb_PersonMonth] PRIMARY KEY CLUSTERED ([PersonMonthID] ASC),
    CONSTRAINT [FK_tb_PersonMonth_tb_Month] FOREIGN KEY ([MonthID]) REFERENCES [dbo].[tb_Month] ([MonthID]),
    CONSTRAINT [FK_tb_PersonMonth_tb_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After edit record create in [tb_PersonMonth]
-- Edit allowed only if curretn year finalized
-- System Events/Anniversaries cannto be erased
-- Updates tb_Timeline

CREATE TRIGGER [dbo].[tr_PersonMonthUPDATE]
   ON [dbo].tb_PersonMonth
   AFTER UPDATE, DELETE
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

			---------------------------------------------------
			DECLARE @D_old NVARCHAR(MAX);
			DECLARE @D_new NVARCHAR(MAX);
			SELECT @D_old = Description FROM deleted;
			SELECT @D_new = Description FROM inserted;

			IF @D_old LIKE '/%' AND @D_new = 'M'
				BEGIN
				RAISERROR ('EDITING SYSTEM EVENTS & ANNIVERSARIES NOT ALLOWED', 16, 1);
				ROLLBACK TRANSACTION;
				RETURN 
				END
			ELSE
				BEGIN
					EXEC [sp_PersonMonthCleanMSlash]
					EXEC [sp_PersonMonthAutosetM]
					--EXEC [dbo].[sp_PersonmonthTOTimeline]
				END;
			---------------------------------------------------

		END
	---------------------------------------------------
END
