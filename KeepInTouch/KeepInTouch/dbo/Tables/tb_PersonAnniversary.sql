CREATE TABLE [dbo].[tb_PersonAnniversary] (
    [PersonAnniversaryID] INT IDENTITY (1, 1) NOT NULL,
    [PersonID]            INT NOT NULL,
    [AnniversaryID]       INT NOT NULL,
    [Day]                 INT NOT NULL,
    [Month]               INT NOT NULL,
    [Year]                INT NULL,
    CONSTRAINT [PK_tb_PersonAnniversary] PRIMARY KEY CLUSTERED ([PersonAnniversaryID] ASC),
    CONSTRAINT [FK_tb_PersonAnniversary_tb_Anniversary] FOREIGN KEY ([AnniversaryID]) REFERENCES [dbo].[tb_Anniversary] ([AnniversaryID]),
    CONSTRAINT [FK_tb_PersonAnniversary_tb_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After new record create in [tb_PersonAnniversary]
-- Create corresponding new record in [tb_PersonMonth]

CREATE TRIGGER [dbo].[tr_PersonAnniversaryINSERT]
   ON [dbo].tb_PersonAnniversary 
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------[tb_PersonMonth]
	DECLARE @PersonID as int;
	DECLARE @MonthID as int;
	DECLARE @Reference as int;

	SELECT @PersonID = PersonID, @MonthID = Month, @Reference = AnniversaryID FROM inserted;

	EXEC [dbo].[sp_PersonMonthUPDATE]@PersonID,@MonthID,@Reference,1,1; -- [tb_PersonMonth] ADD NEW
	---------------------------------------------------

END

GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- After edit record create in [tb_PersonAnniversary]
-- Update corresponding new record in [tb_PersonMonth]

CREATE TRIGGER [dbo].[tr_PersonAnniversaryUPDATE]
   ON [dbo].tb_PersonAnniversary 
   AFTER UPDATE, DELETE
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------
	DECLARE @PersonID as int;

	---------------------------------------------------[tb_PersonMonth] DELETE OLD
	DECLARE @MonthID_Old as int;
	DECLARE @Reference_Old as int;

	SELECT @PersonID = PersonID, @MonthID_Old = Month, @Reference_Old = AnniversaryID FROM deleted;

	EXEC [dbo].[sp_PersonMonthUPDATE]@PersonID,@MonthID_Old,@Reference_Old,1,0;

	---------------------------------------------------[tb_PersonMonth] ADD NEW
	DECLARE @MonthID_New as int;
	DECLARE @Reference_New as int;

	SELECT @PersonID = PersonID, @MonthID_New = Month, @Reference_New = AnniversaryID FROM inserted;

	EXEC [dbo].[sp_PersonMonthUPDATE]@PersonID,@MonthID_New,@Reference_New,1,1;
	---------------------------------------------------

END
