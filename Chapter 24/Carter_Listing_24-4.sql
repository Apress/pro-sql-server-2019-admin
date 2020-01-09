USE Master
GO

CREATE FUNCTION dbo.Classifier()
RETURNS SYSNAME
WITH SCHEMABINDING
AS
BEGIN
        --Declare variables

        DECLARE @WorkloadGroup        SYSNAME ;
        SET @WorkloadGroup = 'Not Assigned' ;

        --Implement business rule 1

        IF (SUSER_NAME() = 'SalesUser')
        BEGIN        
                SET @WorkloadGroup = 'SalesUsers' ;
        END

        --Implement business rule 2

        ELSE IF (SUSER_NAME() = 'SalesManager')
        BEGIN        
                SET @WorkloadGroup = 'Managers' ;
        END
                --Implement business rules 3 & 4
        ELSE IF (SUSER_SNAME() = 'ReportsUser')
        BEGIN
                IF (HOST_NAME() = 'ReportsApp')
                BEGIN
                        SET @WorkloadGroup = 'InternalReports'
                END
                ELSE
                BEGIN
                        SET @WorkloadGroup = 'ExternalReports'
                END
        END

        --Implement business rule 5 (Put all other requests into the default workload group)

        ELSE IF @WorkloadGroup = 'Not Assigned'
        BEGIN
                SET @WorkloadGroup = 'default'
        END

        --Return the apropriate Workload Group name

        RETURN @WorkloadGroup
END

GO

--Associate the Classifier Function with Resource Governor

ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = dbo.Classifier) ;

ALTER RESOURCE GOVERNOR RECONFIGURE ;
