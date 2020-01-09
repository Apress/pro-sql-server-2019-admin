Set-ExecutionPolicy Unrestricted 

import-module SQLPS
import-module servermanager 

Add-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature

New-ADUser SQLUser -AccountPassword (ConvertTo-SecureString -AsPlainText "Pa$$w0rd" -Force) -Server "PROSQLADMIN.COM"
Enable-ADAccount -Identity SQLUser

New-ADUser WinUser -AccountPassword (ConvertTo-SecureString -AsPlainText "Pa$$w0rd" -Force) -Server "PROSQLADMIN.COM"
Enable-ADAccount -Identity WinUser

$perm = [ADSI]"WinNT://SQLServer/Administrators,group" 
$perm.psbase.Invoke("Add",([ADSI]"WinNT://PROSQLADMIN/WinUser").path)

invoke-sqlcmd -ServerInstance .\MasterServer -Query "--Create the database

CREATE DATABASE Chapter22 ;
GO

USE Chapter22
GO


--Create and populate numbers table

DECLARE @Numbers TABLE
(
        Number        INT
)

;WITH CTE(Number)
AS
(
        SELECT 1 Number
        UNION ALL
        SELECT Number + 1
        FROM CTE
        WHERE Number < 100
)
INSERT INTO @Numbers
SELECT Number FROM CTE;

--Create and populate name pieces

DECLARE @Names TABLE
(
        FirstName       VARCHAR(30),
        LastName        VARCHAR(30)
);

INSERT INTO @Names
VALUES('Peter', 'Carter'), 
      ('Michael', 'Smith'), 
      ('Danielle', 'Mead'), 
      ('Reuben', 'Roberts'), 
      ('Iris', 'Jones'), 
      ('Sylvia', 'Davies'), 
      ('Finola', 'Wright'), 
      ('Edward', 'James'), 
      ('Marie', 'Andrews'), 
  ('Jennifer', 'Abraham');

--Create and populate Customers table

CREATE TABLE dbo.Customers
(
        CustomerID           INT            NOT NULL    IDENTITY    PRIMARY KEY,
        FirstName            VARCHAR(30)    NOT NULL,
        LastName             VARCHAR(30)    NOT NULL,
        BillingAddressID     INT            NOT NULL,
        DeliveryAddressID    INT            NOT NULL,
        CreditLimit          MONEY          NOT NULL,
        Balance              MONEY          NOT NULL
);

SELECT * INTO #Customers 
FROM
         (SELECT
                 (SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName,
                 (SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) BillingAddressID,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) DeliveryAddressID,
                 (SELECT TOP 1 CAST(RAND() * Number AS INT) * 10000 
                  FROM @Numbers 
                  ORDER BY NEWID()) CreditLimit,
                 (SELECT TOP 1 CAST(RAND() * Number AS INT) * 9000 
                  FROM @Numbers 
                  ORDER BY NEWID()) Balance
        FROM @Numbers a
) a;

--Create the SQLUser Login and DB User

USE Master
GO

CREATE LOGIN [PROSQLADMIN\sqluser] FROM WINDOWS WITH DEFAULT_DATABASE=Chapter22 ;
GO

USE Chapter22
GO

CREATE USER [PROSQLADMIN\sqluser] FOR LOGIN [PROSQLADMIN\sqluser] ;
GO

--Add the SQLUser to the db_backupoperator group

ALTER ROLE db_backupoperator ADD MEMBER [PROSQLADMIN\sqluser] ;
GO"
