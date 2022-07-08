CREATE TABLE [dbo].[InscriptionLesson]
(
	[Id] INT NOT NULL IDENTITY, 
    [MemberId] INT NOT NULL, 
    [LessonId] INT NOT NULL

    CONSTRAINT PK_InscriptionLesson PRIMARY KEY ([Id]),
    CONSTRAINT FK_InscriptionLesson__MemberId FOREIGN KEY ([MemberId]) REFERENCES Member([Id]),
    CONSTRAINT FK_InscriptionLesson__LessonId FOREIGN KEY ([LessonId]) REFERENCES Lesson([Id]),
    CONSTRAINT UK_InscriptionLesson UNIQUE ([MemberId], [LessonId])
)
