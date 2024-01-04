$UserPath = "$($env:USERPROFILE)\AppData\Loggy.txt"
$date = get-date -format yyyy/mm/dd
$cert = Get-ChildItem Cert:\LocalMachine\Root\ | where-object {$_.Subject -cmatch "USERTrust"} | Select-Object -First 1
Write-Output $env:computername "$($cert.Subject) $($cert.Thumbprint)" $date | Out-File -FilePath $UserPath -Append