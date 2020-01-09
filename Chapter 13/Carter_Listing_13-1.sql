DECLARE @Uptime	DECIMAL(5,3) ;

--Specify the uptime level to calculate

SET @Uptime = 99.9 ;

DECLARE @UptimeInterval VARCHAR(5) ;

--Specify WEEK, MONTH, or YEAR

SET @UptimeInterval = 'YEAR' ;

DECLARE @SecondsPerInterval FLOAT ;

--Calculate seconds per interval

SET @SecondsPerInterval = 
(
SELECT CASE
        WHEN @UptimeInterval = 'YEAR'
                THEN 60*60*24*365.243 
        WHEN @UptimeInterval = 'MONTH'
                THEN 60*60*24*30.437
        WHEN @UptimeInterval = 'WEEK'
                THEN 60*60*24*7
        END
) ;

DECLARE @UptimeSeconds DECIMAL(12,4) ;

--Calculate uptime

SET @UptimeSeconds = @SecondsPerInterval * (100-@Uptime) / 100 ;

--Format results
SELECT 
    CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60/24))   + ' Day(s), ' 
  + CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60 % 24)) + ' Hour(s), '
  + CONVERT(VARCHAR(12),  FLOOR(@UptimeSeconds /60 % 60))    + ' Minute(s), ' 
  + CONVERT(VARCHAR(12),  FLOOR(@UptimeSeconds % 60))        + ' Second(s).' ;
