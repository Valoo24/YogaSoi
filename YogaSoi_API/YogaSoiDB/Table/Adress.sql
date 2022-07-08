CREATE TABLE [dbo].[Adress]
(
	[Id] INT NOT NULL IDENTITY, 
    [City] NVARCHAR(50) NOT NULL, 
    [Postcode] INT NOT NULL, 
    [Street] NVARCHAR(50) NOT NULL, 
    [Street_number] INT NOT NULL, 
    [Country] NVARCHAR(50) NOT NULL

    CONSTRAINT PK_Adress PRIMARY KEY ([Id])
)
