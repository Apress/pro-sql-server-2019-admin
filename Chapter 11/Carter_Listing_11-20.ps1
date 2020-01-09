#Create a SqlConnection object, specifying Column Encryption Setting = enabled
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = "Server=localhost\prosqladmin;Integrated Security=true; Initial Catalog=Chapter11AlwaysEncrypted; Column Encryption Setting=enabled;"

#Open the connection
$sqlConn.Open()

#Create a SqlCommand object, and add the query and parameters
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn
$sqlcmd.CommandText = "INSERT INTO dbo.CreditCards (CardType, CardNumber, ExpMonth, ExpYear, CustomerID) VALUES (@CardType, @CardNumber, @ExpMonth, @ExpYear, @CustomerID)"
$sqlcmd.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@CardType",[Data.SQLDBType]::nVarChar,20)))
$sqlcmd.Parameters["@CardType"].Value = "SuperiorCard"
$sqlcmd.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@CardNumber",[Data.SQLDBType]::nVarChar,20)))
$sqlcmd.Parameters["@CardNumber"].Value = "33332664695310"
$sqlcmd.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@ExpMonth",[Data.SQLDBType]::Int)))
$sqlcmd.Parameters["@ExpMonth"].Value = "12"
$sqlcmd.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@ExpYear",[Data.SQLDBType]::Int)))
$sqlcmd.Parameters["@ExpYear"].Value = "22"
$sqlcmd.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@CustomerID",[Data.SQLDBType]::Int)))
$sqlcmd.Parameters["@CustomerID"].Value = "1"

#Insert the data
$sqlcmd.ExecuteNonQuery();

#Close the connection
$sqlConn.Close()
