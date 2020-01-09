USE Chapter6
GO

CREATE TABLE dbo.ch06_test AS FILETABLE
  WITH
  (
    FILETABLE_DIRECTORY = 'Chapter6_FileTable',
    FILETABLE_COLLATE_FILENAME = database_default
  );
GO
