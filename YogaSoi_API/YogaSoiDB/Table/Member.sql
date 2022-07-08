CREATE TABLE [dbo].[Member]
(
	[Id] INT NOT NULL IDENTITY, 
    [Firstname] NVARCHAR(50) NOT NULL, 
    [Surname] NVARCHAR(50) NOT NULL, 
    [Pseudo] NVARCHAR(50) NOT NULL, 
    [Hashed_password] NVARCHAR(50) NOT NULL, 
    [RoleId] INT NOT NULL, 
    [Is_admin] BIT NOT NULL, 

    CONSTRAINT PK_Member PRIMARY KEY ([Id]),
    CONSTRAINT UK_Member__Pseudo UNIQUE ([Pseudo]),
    CONSTRAINT FK_Member__RoleId FOREIGN KEY ([RoleId]) REFERENCES Role([Id])
)