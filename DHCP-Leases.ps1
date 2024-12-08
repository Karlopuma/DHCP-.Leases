# Define the output CSV file path, edit this line to change output location
$outputCsv = "C:\DHCP-Leases\DCHP-Leases.csv"

# Define the header for the CSV file
$header = @("ScopeId;IPAddress;HostName;ClientID;AddressState")

# Initialize the CSV file with the header
$header | Out-File -FilePath $outputCsv -Encoding UTF8

# Retrieve all DHCP scopes from the DHCP server
$scopes = Get-DhcpServerv4Scope

# Iterate through each scope to retrieve leases
foreach ($scope in $scopes) {
    $leases = Get-DhcpServerv4Lease -ScopeId $scope.ScopeId

    # Process each lease and format the data
    foreach ($lease in $leases) {
        $row = "$($scope.ScopeId);$($lease.IPAddress);$($lease.HostName);$($lease.ClientId);$($lease.AddressState)"
        $row | Out-File -FilePath $outputCsv -Append -Encoding UTF8
    }
}

Write-Host "DHCP leases have been exported to $outputCsv"