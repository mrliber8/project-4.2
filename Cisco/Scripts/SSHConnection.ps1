$secpasswd = ConvertTo-SecureString "hdwn2" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("hdwn2", $secpasswd)

$session = New-SSHSession -ComputerName "10.14.100.2" -Credential $creds -AcceptKey -Force

$stream = $session.Session.CreateShellStream("dumb", 0, 0, 0, 0, 1000)

$result = Invoke-SSHStreamExpectSecureAction -ShellStream $stream -Command "en `n" -ExpectString "Password:" -SecureAction $secpasswd -verbose

sleep -Milliseconds 150
$stream.WriteLine("conf t")
sleep -sec 1
$stream.Read()
sleep -Milliseconds 50
$stream.WriteLine("do show run")
sleep -Milliseconds 50
$stream.WriteLine("exit")
sleep -sec 1
$stream.Read()
Remove-SSHSession -Index 0