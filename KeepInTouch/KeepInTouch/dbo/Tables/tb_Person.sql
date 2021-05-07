CREATE TABLE [dbo].[tb_Person] (
    [PersonID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (50) NOT NULL,
    [RelationID] INT           NOT NULL,
    CONSTRAINT [PK_tb_Person] PRIMARY KEY CLUSTERED ([PersonID] ASC),
    CONSTRAINT [FK_tb_Person_tb_Relation] FOREIGN KEY ([RelationID]) REFERENCES [dbo].[tb_Relation] ([RelationID])
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- Block delete
-- tb_Person

CREATE TRIGGER [dbo].[tr_PersonDELETE]
   ON [dbo].[tb_Person] 
   FOR DELETE
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
-- After new record create in [tb_Person]
-- Create corresponding new record in [tb_PersonEvent] and [tb_PersonMonth]

CREATE TRIGGER [dbo].[tr_PersonINSERT]
   ON [dbo].[tb_Person] 
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------[tb_PersonEvent]
	EXEC [dbo].[sp_PersonEventADD];
	---------------------------------------------------[tb_PersonMonth]
	EXEC [dbo].[sp_PersonMonthADD];
	---------------------------------------------------
END
