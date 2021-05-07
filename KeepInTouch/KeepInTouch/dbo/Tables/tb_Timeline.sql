CREATE TABLE [dbo].[tb_Timeline] (
    [PersonID]      INT            NOT NULL,
    [Jan]           NVARCHAR (500) NULL,
    [Feb]           NVARCHAR (500) NULL,
    [Mar]           NVARCHAR (500) NULL,
    [Apr]           NVARCHAR (500) NULL,
    [May]           NVARCHAR (500) NULL,
    [Jun]           NVARCHAR (500) NULL,
    [Jul]           NVARCHAR (500) NULL,
    [Aug]           NVARCHAR (500) NULL,
    [Sep]           NVARCHAR (500) NULL,
    [Oct]           NVARCHAR (500) NULL,
    [Nov]           NVARCHAR (500) NULL,
    [Dec]           NVARCHAR (500) NULL,
    [MonthsPerYear] INT            NULL,
    [Deficit]       INT            NULL,
    CONSTRAINT [PK_tb_Timeline] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);

