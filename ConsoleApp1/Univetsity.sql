CREATE TABLE [dbo].[faculties] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [name] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[departments] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [name]         NVARCHAR (70) NOT NULL,
    [faculties_id] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_departments_Tofaculties] FOREIGN KEY ([faculties_id]) REFERENCES [dbo].[faculties] ([Id])
);

CREATE TABLE [dbo].[groups] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          NVARCHAR (50) NOT NULL,
    [form_of_study] NVARCHAR (50) NOT NULL,
    [speciality]    NVARCHAR (70) NOT NULL,
    [course]        INT           NOT NULL,
    [faculties_id]  INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_groups_Tofaculties] FOREIGN KEY ([faculties_id]) REFERENCES [dbo].[faculties] ([Id])
);

CREATE TABLE [dbo].[students] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [firstname]  NVARCHAR (50) NOT NULL,
    [lastname]   NVARCHAR (50) NOT NULL,
    [middlename] NVARCHAR (50) NOT NULL,
    [birthday]   DATE          NOT NULL,
    [gender]     NVARCHAR (15) NOT NULL,
    [groups_id]  INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_students_Togroups] FOREIGN KEY ([groups_id]) REFERENCES [dbo].[groups] ([Id])
);

CREATE TABLE [dbo].[teachers] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [firstname]     NVARCHAR (50) NOT NULL,
    [lastname]      NVARCHAR (50) NOT NULL,
    [middlename]    NVARCHAR (50) NOT NULL,
    [birthday]      DATE          NOT NULL,
    [position]      NVARCHAR (50) NOT NULL,
    [department_id] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_teachers_ToDepartments] FOREIGN KEY ([department_id]) REFERENCES [dbo].[departments] ([Id])
);

CREATE TABLE [dbo].[subjects] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [name]         NVARCHAR (50)  NOT NULL,
    [description]  NVARCHAR (200) NOT NULL,
    [is_exam]      BIT            DEFAULT ((1)) NULL,
    [is_selective] BIT            DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[subjects_teacher] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [subjects_id] INT NOT NULL,
    [teachers_id] INT NOT NULL,
    [groups_id]   INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_subjects_teacher_ToSubjects] FOREIGN KEY ([subjects_id]) REFERENCES [dbo].[subjects] ([Id]),
    CONSTRAINT [FK_subjects_teacher_ToTeachers] FOREIGN KEY ([teachers_id]) REFERENCES [dbo].[teachers] ([Id]),
    CONSTRAINT [FK_subjects_teacher_ToGroups] FOREIGN KEY ([groups_id]) REFERENCES [dbo].[groups] ([Id])
);

CREATE TABLE [dbo].[grades] (
    [Id]          INT      IDENTITY (1, 1) NOT NULL,
    [value]       INT      NULL,
    [date]        DATETIME NOT NULL,
    [subjects_id] INT      NOT NULL,
    [students_id] INT      NOT NULL,
    [teachers_id] INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_grades_ToSubjects] FOREIGN KEY ([subjects_id]) REFERENCES [dbo].[subjects] ([Id]),
    CONSTRAINT [FK_grades_ToStudents] FOREIGN KEY ([students_id]) REFERENCES [dbo].[students] ([Id]),
    CONSTRAINT [FK_grades_ToTeachers] FOREIGN KEY ([teachers_id]) REFERENCES [dbo].[teachers] ([Id])
);