CREATE TABLE [dbo].[Role]
(
	[Id] INT NOT NULL IDENTITY, 
    [Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Role PRIMARY KEY ([Id])
)
