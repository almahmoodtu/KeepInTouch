CREATE TABLE [dbo].[tb_PersonFrequency] (
    [PersonFrequencyID] INT IDENTITY (1, 1) NOT NULL,
    [PersonID]          INT NOT NULL,
    [FrequencyID]       INT NOT NULL,
    CONSTRAINT [PK_tb_PersonFrequency] PRIMARY KEY CLUSTERED ([PersonFrequencyID] ASC),
    CONSTRAINT [FK_tb_PersonFrequency_tb_Frequency] FOREIGN KEY ([FrequencyID]) REFERENCES [dbo].[tb_Frequency] ([FrequencyID]),
    CONSTRAINT [FK_tb_PersonFrequency_tb_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID]) ON DELETE CASCADE ON UPDATE CASCADE
);

