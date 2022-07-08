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
/*
La colonne [dbo].[User].[Inscrit] est en cours de suppression, des données risquent d'être perdues.
*/

IF EXISTS (select top 1 1 from [dbo].[User])
    RAISERROR (N'Lignes détectées. Arrêt de la mise à jour du schéma en raison d''''un risque de perte de données.', 16, 127) WITH NOWAIT

GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé 6f67c4cf-bb62-4ac4-a9a5-98cc982d1b81 est ignorée, l''élément [dbo].[Inscrit].[User] (SqlSimpleColumn) ne sera pas renommé en UserId';


GO
PRINT N'L''opération de refactorisation de changement de nom avec la clé bbfd18ce-cdcb-43bc-87f1-3f43b770c576 est ignorée, l''élément [dbo].[Inscrit].[Lesson] (SqlSimpleColumn) ne sera pas renommé en LessonId';


GO
PRINT N'L''opération suivante a été générée à partir d''un fichier journal de refactorisation 909a5a0a-37e6-4794-83c5-d0103967b5bd';

PRINT N'Renommer [dbo].[User].[Role] en RoleId';


GO
EXECUTE sp_rename @objname = N'[dbo].[User].[Role]', @newname = N'RoleId', @objtype = N'COLUMN';


GO
PRINT N'Suppression de Clé étrangère [dbo].[FK_User__Role]...';


GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK_User__Role];


GO
PRINT N'Suppression de Clé primaire [dbo].[PK_User]...';


GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_User];


GO
PRINT N'Modification de Table [dbo].[User]...';


GO
ALTER TABLE [dbo].[User] DROP COLUMN [Inscrit];


GO
PRINT N'Création de Clé étrangère [dbo].[FK_User__RoleId]...';


GO
ALTER TABLE [dbo].[User] WITH NOCHECK
    ADD CONSTRAINT [FK_User__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]);


GO
-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6f67c4cf-bb62-4ac4-a9a5-98cc982d1b81')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6f67c4cf-bb62-4ac4-a9a5-98cc982d1b81')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bbfd18ce-cdcb-43bc-87f1-3f43b770c576')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bbfd18ce-cdcb-43bc-87f1-3f43b770c576')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '909a5a0a-37e6-4794-83c5-d0103967b5bd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('909a5a0a-37e6-4794-83c5-d0103967b5bd')

GO

GO
PRINT N'Vérification de données existantes par rapport aux nouvelles contraintes';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[User] WITH CHECK CHECK CONSTRAINT [FK_User__RoleId];


GO
PRINT N'Mise à jour terminée.';


GO
