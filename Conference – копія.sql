CREATE DATABASE [Conference_v1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Conference_v1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Conference_v1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Conference_v1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Conference_v1_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Conference_v1] SET COMPATIBILITY_LEVEL = 130
GO

USE Conference_v1
GO

CREATE TABLE Conference (
	ConfId int IDENTITY (1,1),
	[Name] varchar(30) NOT NULL UNIQUE ,
	TimeStart date NOT NULL,
	TimeEnd date NOT NULL,
	Build_addres varchar(50) NOT NULL
)

--
ALTER TABLE Conference /*додаємо ключ*/
ADD CONSTRAINT PK_Conference_ConfId PRIMARY KEY CLUSTERED (ConfId)
GO

--Time limit
ALTER TABLE Conference
ADD CONSTRAINT DT_Conference_TimeStart CHECK (TimeStart >= getdate())
GO

ALTER TABLE Conference
ADD CONSTRAINT DT_Conference_TimeEnd CHECK (TimeEnd >= TimeStart)
GO

--DANGER
TRUNCATE TABLE Reporter
GO

CREATE TABLE Section (
	[Name] varchar(30) NOT NULL UNIQUE,
	Number int IDENTITY (1,1),
	Number_room int NOT NULL,
	Manager varchar(30) NOT NULL
)

--
ALTER TABLE Section /*додаємо ключ*/
ADD CONSTRAINT PK_Section_Number PRIMARY KEY CLUSTERED (Number)
GO

CREATE TABLE Performance(
	Topic varchar(30) NOT NULL,
	Time_Date_Start datetime NOT NULL,
	Duration time NOT NULL,
	PerID int IDENTITY (1,1)
)

-- Time_Date_Start >= Conference.TimeStart ???
/*
ALTER TABLE Performance
ADD CONSTRAINT DT_Performance_Time_Date_Start CHECK (Time_Date_Start >= getdate())
GO
*/

ALTER TABLE Performance /*додаємо ключ*/
ADD CONSTRAINT PK_Performance_PerID PRIMARY KEY CLUSTERED (PerID)
GO

CREATE TABLE Reporter(
	[Name] varchar(30) NOT NULL,
	Science_Degree varchar(30) NOT NULL,
	Academic_status varchar(30) NOT NULL,
	place_of_work varchar(30) NOT NULL DEFAULT 'None',
	Post varchar(30) NOT NULL DEFAULT 'None',
	Professional_biography varchar(100) NOT NULL,
	RepID int IDENTITY (1,1)
)

ALTER TABLE Reporter /*додаємо ключ*/
ADD CONSTRAINT PK_Reporter_RepID PRIMARY KEY CLUSTERED (RepID)
GO

CREATE TABLE Equipment(
	EqID int IDENTITY (1,1),
	[Name] varchar(30) NOT NULL
)

ALTER TABLE Equipment /*додаємо ключ*/
ADD CONSTRAINT PK_Equipment_EqID PRIMARY KEY CLUSTERED (EqID)
GO


-------------ADD FOREIGN KEY---------
ALTER TABLE Section
ADD ConfID int NOT NULL
GO 


--ASK ABOUT DELETE CASCADE ----------
ALTER TABLE Section
WITH CHECK /*перевірка для уже існуючих значень*/ ADD CONSTRAINT FK_Section_Conference FOREIGN KEY(ConfID)
REFERENCES Conference (ConfID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

-----------------------------------------------
ALTER TABLE Performance
ADD Number int NOT NULL
GO 

ALTER TABLE Performance
WITH CHECK ADD CONSTRAINT FK_Performance_Section FOREIGN KEY(Number)
REFERENCES Section (Number)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

-----------------------------------------------------
ALTER TABLE Reporter
ADD PerID int NOT NULL
GO 

ALTER TABLE Reporter
WITH CHECK ADD CONSTRAINT FK_Reporter_Performance FOREIGN KEY(PerID)
REFERENCES Performance (PerID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

------------------------------------------------------

ALTER TABLE Equipment
ADD PerID int NOT NULL
GO 

ALTER TABLE Equipment
WITH CHECK ADD CONSTRAINT FK_Equipment_Performance FOREIGN KEY(PerID)
REFERENCES Performance (PerID)
ON UPDATE CASCADE
ON DELETE CASCADE
GO