# Get the local device hostname
$hostname = $env:COMPUTERNAME

# Get the first trusted root certificate with "USERTrust" in the subject
$cert = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*USERTrust*" } | Select-Object -First 1

# Check if a certificate is found
if ($cert) {
    # Get certificate details
    $certSubject = $cert.Subject
    $certThumbprint = $cert.Thumbprint
} else {
    Write-Host "No trusted root certificate with 'USERTrust' in the subject found."
    exit
}

# Create a timestamp
$dateStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Define the file path in AppData for the current user
$filePath = Join-Path $env:APPDATA "CertificateDetails.txt"

# Write details and timestamp to the text file
@"
Hostname: $hostname
Certificate Subject: $certSubject
Certificate Thumbprint: $certThumbprint
Timestamp: $dateStamp
"@ | Out-File -FilePath $filePath -Append

Write-Host "Details written to: $filePath"

