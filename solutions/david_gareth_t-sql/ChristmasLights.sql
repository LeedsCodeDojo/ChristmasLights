/* This script assumes that the dbo.Commands table will be populated from a file by an external ETL process */

USE tempdb
GO

DROP DATABASE ChristmasLights
GO

CREATE DATABASE ChristmasLights
GO

USE ChristmasLights
GO

SET NOCOUNT ON
GO

----------------------------------------------- TABLES ---------------------------------------------

CREATE TABLE dbo.Commands
(
	Id			INTEGER IDENTITY(1,1)	NOT NULL,
	[Action]	VARCHAR(6)				NOT NULL,
	xStart		INTEGER					NOT NULL, 
	yStart		INTEGER					NOT NULL, 
	xEnd		INTEGER					NOT NULL, 
	yEnd		INTEGER					NOT NULL,
	CONSTRAINT pk_Commands PRIMARY KEY (Id),
	CONSTRAINT ck_Commands_Action CHECK (Action IN ('On','Off','Toggle')),
	CONSTRAINT ck_Commands_X CHECK (xEnd >= xStart AND xStart >= 0),
	CONSTRAINT ck_Commands_Y CHECK (yEnd >= yStart AND yStart >= 0),
)
GO

CREATE TABLE dbo.Lights
(
	RowNumber INTEGER IDENTITY(1,1) NOT NULL,
	Bulbs	  CHAR(30)				NOT NULL,
	CONSTRAINT pk_Lights PRIMARY KEY (RowNumber)
)
GO

CREATE TABLE dbo.Numbers
(
	n INT IDENTITY(1,1) NOT NULL PRIMARY KEY
)
GO

----------------------------------------------- DATA ---------------------------------------------


INSERT INTO dbo.Lights SELECT '********'
GO 25
go


INSERT INTO numbers DEFAULT VALUES
GO 30
go


----------------------------------------------- PROCEDURES ---------------------------------------------


CREATE PROCEDURE dbo.[On] (@xStart integer, @yStart integer, @xEnd integer, @yEnd integer)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Lights
	   SET Bulbs = LEFT(Bulbs, @xStart) + REPLICATE('*', @xEnd - @xStart+1) + SUBSTRING(Bulbs, @xEnd+2, 9999)
	 WHERE RowNumber BETWEEN @yStart AND @yEnd
END

GO

CREATE PROCEDURE dbo.[Off] (@xStart integer, @yStart integer, @xEnd integer, @yEnd integer)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Lights
	   SET Bulbs = LEFT(Bulbs, @xStart) + REPLICATE('.', @xEnd - @xStart+1) + SUBSTRING(Bulbs, @xEnd+2, 9999)
	 WHERE RowNumber BETWEEN @yStart AND @yEnd
END
GO

CREATE FUNCTION dbo.Invert(@lights AS VARCHAR(100)) RETURNS VARCHAR(100) AS
BEGIN
	DECLARE @result AS VARCHAR(100)

	SELECT @result = STRING_AGG(case substring(@lights, n.n, 1) WHEN '*' THEN '.' ELSE '*' END,'')
	  FROM numbers n
	 WHERE n <= len(@lights)

	RETURN @result
END
GO

CREATE PROCEDURE dbo.Toggle (@xStart INTEGER, @yStart INTEGER, @xEnd INTEGER, @yEnd INTEGER) AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Lights
	   SET Bulbs = LEFT(Bulbs, @xStart) +dbo.Invert(substring(Bulbs, @xStart, (@xEnd - @xStart)+1)) + SUBSTRING(Bulbs, @xEnd+2, 9999)
	 WHERE RowNumber BETWEEN @yStart AND @yEnd
END
GO

CREATE PROCEDURE dbo.Display AS
BEGIN
	SET NOCOUNT ON

	SELECT REPLACE(L.Bulbs,'.',' ')
	  FROM dbo.Lights L
	ORDER BY L.RowNumber
END
GO

CREATE PROCEDURE dbo.ResetLights AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Lights
	   SET Bulbs = REPLICATE('.', 30)

END
GO

CREATE PROCEDURE dbo.Run(@ID INTEGER, @Action VARCHAR(10), @xStart INTEGER, @yStart INTEGER, @xEnd INTEGER, @yEnd INTEGER)  AS
BEGIN
	SET NOCOUNT ON

	IF @Action = 'On'
		EXEC [dbo].[On] @xStart, @yStart, @xEnd, @yEnd

	ELSE IF @Action = 'Off'
		EXEC [dbo].[Off] @xStart, @yStart, @xEnd, @yEnd

	ELSE IF @Action = 'Toggle'
		EXEC [dbo].[Toggle] @xStart, @yStart, @xEnd, @yEnd

	ELSE
		RAISERROR('Invalid Action',16,1)

	RETURN @ID
END
GO

CREATE PROCEDURE dbo.RunAllCommands AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Id     INTEGER
	DECLARE @Action VARCHAR(6)
	DECLARE @xStart INTEGER 
	DECLARE @yStart INTEGER
	DECLARE @xEnd	INTEGER 
	DECLARE @yEnd	INTEGER 

	DECLARE cur CURSOR READ_ONLY
	FOR SELECT C.ID, C.Action, C.xStart, C.yStart, C.xEnd, C.yEnd 
	      FROM dbo.Commands C 
	  ORDER BY C.ID

	OPEN cur

	FETCH NEXT FROM cur INTO @id, @Action, @xStart, @yStart, @xEnd, @yEnd
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
		BEGIN
			EXEC dbo.Run @id, @Action, @xStart, @yStart, @xEnd, @yEnd
		END
		FETCH NEXT FROM cur INTO @id, @Action, @xStart, @yStart, @xEnd, @yEnd
	END

	CLOSE cur
	DEALLOCATE cur
END
GO


INSERT INTO dbo.Commands
VALUES
	('On', 14,1,14,1),
	('On', 12,2,16,2),
	('On', 10,3,18,3),
	('On',  8,4,20,4),
	('On',  6,5,22,5),
	('On',  4,6,24,6),
	('On',  2,7,26,7),
	('On',  0,8,28,8),

	('On',  10, 9,18, 9),
	('On',   8,10,20,10),
	('On',   6,11,22,11),
	('On',   4,12,24,12),
	('On',   2,13,26,13),
	('On',   0,14,28,14),

	('On',  10,15,18,15),
	('On',   8,16,20,16),
	('On',   6,17,22,17),
	('On',   4,18,24,18),
	('On',   2,19,26,19),
	('On',   0,20,28,20),

	('On',   13,21,16,21),
	('On',   13,22,16,22),
	('On',   13,23,16,23),
	('On',   13,24,16,24),
	('On',   13,25,16,25)

go

EXEC ResetLights
EXEC RunAllCommands
--EXEC Toggle 0,1,30,25
EXEC Display
GO
