param($server=".", $database, $outputFolder="diagrams")
#File path no trailing backslashes!

# http://joelmansford.wordpress.com/2008/04/01/scripting-sql-server-diagrams-to-files-for-source-control/
# http://stackoverflow.com/questions/895228/add-database-diagram-to-source-control/895277#895277

if ( -not (Test-Path $outputFolder) ) {New-Item $outputFolder  -Type Directory  | Out-Null}

$conn = new-object System.Data.SqlClient.SqlConnection
# Timeout is in seconds, extended from 30sec default to cope with databases with many diagrams
# https://github.com/timabell/database-diagram-scm/issues/1
$conn.ConnectionString = "server=" + $server + ";integrated security=true;database=" + $database
"Server: '" + $server + "' database: '" + $database + "'"
$conn.Open()
$cmd = new-object System.Data.SqlClient.SqlCommand
$cmd.Connection=$conn

foreach ($f in Get-ChildItem -path "lib\" -Filter *.sql | sort-object )
{
	"Installing prequisite 'lib\" + $f + "'"
	$cmd.CommandText = [IO.File]::ReadAllText("lib\" + $f)  # http://stackoverflow.com/a/7976784/10245
	$result = $cmd.ExecuteNonQuery()
}

"Requesting diagram definitions..."
$cmd.CommandText = "EXEC  [dbo].[spDev_ScriptDiagrams] @name = NULL"
$timeout = 300;
$cmd.CommandTimeout = $timeout;
"Timeout set to " + $timeout + " seconds..."
$dr=$cmd.ExecuteReader()
while ($dr.Read()) {
	$name = $dr.GetValue(0)
	$f = $outputFolder+"\"+$name+".sql"
	$line = $dr.GetValue(1)
	$line | out-file $f -encoding ASCII
	"Scripted '"+$name+"' to " +$f
}
"Diagrams retrieved. Closing connections..."
$dr.Close()
$conn.Close()
"Done."