CREATE TABLE Blog(
	BlogId int IDENTITY(1,1),
	Name nvarchar(50) NOT NULL,
	[Description] nvarchar(250) NULL,
	CreatedDate datetime NOT NULL
)
GO

ALTER TABLE Blog
ADD	CONSTRAINT PK_Blog_BlogID PRIMARY KEY CLUSTERED (BlogId)
GO

ALTER TABLE Blog
ADD CONSTRAINT DF_Blog_CreatedDate_Default  DEFAULT (getdate()) FOR CreatedDate
GO

ALTER TABLE Blog
ADD UserId int NOT NULL
GO
/*Create FOREIGN KEY*/
ALTER TABLE Blog
WITH CHECK ADD CONSTRAINT FK_Blog_BlogUser FOREIGN KEY(UserId)
REFERENCES BlogUser (UserId)
/*cascade - if delete user - delete blog*/
ON UPDATE CASCADE
ON DELETE CASCADE
GO