CREATE TABLE [dbo].[Lesson]
(
	[Id] INT NOT NULL IDENTITY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [AdressId] INT NOT NULL, 
    [Hour] INT NOT NULL, 
    [Minutes] INT NOT NULL,

    CONSTRAINT PK_Lesson PRIMARY KEY ([Id]),
    CONSTRAINT UK_Lesson UNIQUE ([Name], [Hour], [Minutes]),
    CONSTRAINT FK_Lesson__AdressId FOREIGN KEY ([AdressId]) REFERENCES Adress([Id])
)