CREATE TABLE [dbo].[tb_Relation] (
    [RelationID]  INT           IDENTITY (1, 1) NOT NULL,
    [Relation]    NVARCHAR (50) NOT NULL,
    [FrequencyID] INT           NOT NULL,
    CONSTRAINT [PK_tb_Relation] PRIMARY KEY CLUSTERED ([RelationID] ASC),
    CONSTRAINT [FK_tb_Relation_tb_Frequency] FOREIGN KEY ([FrequencyID]) REFERENCES [dbo].[tb_Frequency] ([FrequencyID])
);


GO

-- KeepInTouch
-- CREATING TRIGGER
------------------------------------
-- Block delete
-- tb_Relation

CREATE TRIGGER tr_RelationDELETE
   ON tb_Relation
   INSTEAD OF DELETE
AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------
	RAISERROR ('DELETING RECORDS IS NOT PERMITTED.', 16, 1);
	--------------------------------------------

END
