$secpasswd = ConvertTo-SecureString "passwd" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("passwd", $secpasswd)

$session = New-SSHSession -ComputerName "10.14.100.2" -Credential $creds -AcceptKey -Force

$stream = $session.Session.CreateShellStream("dumb", 0, 0, 0, 0, 1000)

$result = Invoke-SSHStreamExpectSecureAction -ShellStream $stream -Command "en `n" -ExpectString "Password:" -SecureAction $secpasswd -verbose

Start-Sleep -Milliseconds 150
$stream.WriteLine("conf t")
Start-Sleep -sec 1
$stream.Read()
Start-Sleep -Milliseconds 50
$stream.WriteLine("do show run")
Start-Sleep -Milliseconds 50
$stream.WriteLine("exit")
Start-Sleep -sec 1
$stream.Read()
Remove-SSHSession -Index 0