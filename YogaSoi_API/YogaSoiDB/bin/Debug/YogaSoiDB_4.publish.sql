/*
Script de déploiement pour YogaSoiDB

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "YogaSoiDB"
:setvar DefaultFilePrefix "YogaSoiDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Création de Table [dbo].[Adress]...';


GO
CREATE TABLE [dbo].[Adress] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [City]          NVARCHAR (50) NOT NULL,
    [Postcode]      INT           NOT NULL,
    [Street]        NVARCHAR (50) NOT NULL,
    [Street_number] INT           NOT NULL,
    [Country]       NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Adress] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[InscriptionLesson]...';


GO
CREATE TABLE [dbo].[InscriptionLesson] (
    [Id]       INT IDENTITY (1, 1) NOT NULL,
    [MemberId] INT NOT NULL,
    [LessonId] INT NOT NULL,
    CONSTRAINT [PK_InscriptionLesson] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_InscriptionLesson] UNIQUE NONCLUSTERED ([MemberId] ASC, [LessonId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Lesson]...';


GO
CREATE TABLE [dbo].[Lesson] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (50) NOT NULL,
    [AdressId] INT           NOT NULL,
    [Hour]     INT           NOT NULL,
    [Minutes]  INT           NOT NULL,
    CONSTRAINT [PK_Lesson] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_Lesson] UNIQUE NONCLUSTERED ([Name] ASC, [Hour] ASC, [Minutes] ASC)
);


GO
PRINT N'Création de Table [dbo].[Member]...';


GO
CREATE TABLE [dbo].[Member] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [Firstname]       NVARCHAR (50) NOT NULL,
    [Surname]         NVARCHAR (50) NOT NULL,
    [Pseudo]          NVARCHAR (50) NOT NULL,
    [Hashed_password] NVARCHAR (50) NOT NULL,
    [RoleId]          INT           NOT NULL,
    [Is_admin]        BIT           NOT NULL,
    CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_Member__Pseudo] UNIQUE NONCLUSTERED ([Pseudo] ASC)
);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_InscriptionLesson__MemberId]...';


GO
ALTER TABLE [dbo].[InscriptionLesson] WITH NOCHECK
    ADD CONSTRAINT [FK_InscriptionLesson__MemberId] FOREIGN KEY ([MemberId]) REFERENCES [dbo].[Member] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_InscriptionLesson__LessonId]...';


GO
ALTER TABLE [dbo].[InscriptionLesson] WITH NOCHECK
    ADD CONSTRAINT [FK_InscriptionLesson__LessonId] FOREIGN KEY ([LessonId]) REFERENCES [dbo].[Lesson] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Lesson__AdressId]...';


GO
ALTER TABLE [dbo].[Lesson] WITH NOCHECK
    ADD CONSTRAINT [FK_Lesson__AdressId] FOREIGN KEY ([AdressId]) REFERENCES [dbo].[Adress] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Member__RoleId]...';


GO
ALTER TABLE [dbo].[Member] WITH NOCHECK
    ADD CONSTRAINT [FK_Member__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]);


GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[InscriptionLesson] WITH CHECK CHECK CONSTRAINT [FK_InscriptionLesson__MemberId];

ALTER TABLE [dbo].[InscriptionLesson] WITH CHECK CHECK CONSTRAINT [FK_InscriptionLesson__LessonId];

ALTER TABLE [dbo].[Lesson] WITH CHECK CHECK CONSTRAINT [FK_Lesson__AdressId];

ALTER TABLE [dbo].[Member] WITH CHECK CHECK CONSTRAINT [FK_Member__RoleId];


GO
PRINT N'Mise à jour terminée.';


GO
