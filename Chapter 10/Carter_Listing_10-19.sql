USE Chapter10
GO

CREATE TABLE dbo.CreditCards
(
	CardID     INT           NOT NULL,
	CardType   NVARCHAR(50)  NOT NULL,
	CardNumber NVARCHAR(20)  NOT NULL,
	ExpMonth   INT NOT NULL,
	ExpYear    INT NOT NULL,
	CustomerID INT NOT NULL
) ;

INSERT INTO dbo.CreditCards
VALUES(1, 'SuperiorCard', '33332664695310', 10, 20, 991),
(2, 'Distinguish', '55552127249722', 11, 21, 156),
(3, 'ColonialVoice', '77778344838353', 10, 21, 1),
(4, 'ColonialVoice', '77774915718248', 12, 22, 920),
(5, 'Vista', '11114404600042', 12, 22, 949),
(6, 'Distinguish', '55557132036181', 12, 22, 912),
(7, 'Distinguish', '55553635401028', 10, 19, 65),
(8, 'SuperiorCard', '33336081193101', 10, 19, 69),
(9, 'Distinguish', '55553465625901', 12, 19, 846),
(10, 'SuperiorCard', '33332126386493', 12, 19, 495) ;
