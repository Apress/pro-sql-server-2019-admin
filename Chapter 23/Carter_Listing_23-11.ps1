sl "C:\Users\Administrator\Documents\SQL Server Management Studio\Policies"

Invoke-PolicyEvaluation -Policy "C:\Users\Administrator\Documents\SQL Server Management Studio\Policies\DatabaseNameConvention.xml" -TargetServerName ".\MASTERSERVER"
