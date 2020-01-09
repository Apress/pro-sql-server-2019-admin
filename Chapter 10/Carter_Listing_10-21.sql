EXECUTE AS USER = ‘Danielle’ ;
  SELECT 
       CardID
      ,CardType
      ,CardNumber
  FROM Application.CreditCards ;
REVERT
