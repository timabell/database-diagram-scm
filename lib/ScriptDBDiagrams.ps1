param($server=".", $database, $outputFolder="diagrams")
#File path no trailing backslashes!

# http://joelmansford.wordpress.com/2008/04/01/scripting-sql-server-diagrams-to-files-for-source-control/
# http://stackoverflow.com/questions/895228/add-database-diagram-to-source-control/895277#895277

if ( -not (Test-Path $outputFolder) ) {New-Item $outputFolder  -Type Directory  | Out-Null}

$conn = new-object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "server=" + $server + ";integrated security=true;database=" + $database
"Connecting to server " + $server + " database=" + $database
$conn.Open()
$cmd = new-object System.Data.SqlClient.SqlCommand
$cmd.Connection=$conn

foreach ($f in Get-ChildItem -path "lib\" -Filter *.sql | sort-object )
{
	"Installing prequisite 'lib\" + $f + "'"
	$cmd.CommandText = [IO.File]::ReadAllText("lib\" + $f)  # http://stackoverflow.com/a/7976784/10245
	$result = $cmd.ExecuteNonQuery()
}

$cmd.CommandText = "EXEC  [dbo].[spDev_ScriptDiagrams] @name = NULL"
$dr=$cmd.ExecuteReader()
while ($dr.Read()) {
	$name = $dr.GetValue(0)
	$f = $outputFolder+"\"+$name+".sql"
	$line = $dr.GetValue(1)
	$line | out-file $f -encoding ASCII
	"Scripted '"+$name+"' to " +$f
}
$dr.Close()
$conn.Close()
