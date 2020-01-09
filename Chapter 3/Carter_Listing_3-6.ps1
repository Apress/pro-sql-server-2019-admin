$parameters = @{
	ServerInstance = ‘localhost\PROSQLADMINCORE2’
	Query               = “
		SELECT 
  		    @@SERVERNAME
		  , @@VERSION
“
}

Invoke-sqlcmd @parameters
