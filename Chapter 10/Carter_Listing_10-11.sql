--Enable contained databases at the instance level

EXEC sp_configure 'show advanced options', 1 ;
GO

RECONFIGURE ;
GO

EXEC sp_configure 'contained database authentication', '1' ;
GO

RECONFIGURE WITH OVERRIDE ;
GO

--Set Chapter10 database to use partial containment

USE Master
GO

ALTER DATABASE [Chapter10] SET CONTAINMENT = PARTIAL WITH NO_WAIT ;
GO
