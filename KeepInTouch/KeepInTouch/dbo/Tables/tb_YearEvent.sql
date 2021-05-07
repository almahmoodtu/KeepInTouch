CREATE TABLE [dbo].[tb_YearEvent] (
    [YearEventID] INT IDENTITY (1, 1) NOT NULL,
    [YearID]      INT NOT NULL,
    [EventID]     INT NOT NULL,
    [Day]         INT NULL,
    [Month]       INT NULL,
    CONSTRAINT [PK_tb_YearEvent] PRIMARY KEY CLUSTERED ([YearEventID] ASC),
    CONSTRAINT [FK_tb_YearEvent_tb_Event] FOREIGN KEY ([EventID]) REFERENCES [dbo].[tb_Event] ([EventID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_tb_YearEvent_tb_Year] FOREIGN KEY ([YearID]) REFERENCES [dbo].[tb_Year] ([YearID]) ON DELETE CASCADE ON UPDATE CASCADE
);

