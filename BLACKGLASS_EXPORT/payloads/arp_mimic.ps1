param (
    [string]$TargetIP = "192.168.1.10",
    [string]$SpoofIP = "192.168.1.1"
)

function Spoof-ARP {
    $mac = "00:11:22:33:44:55"
    $packet = @{
        Destination = $TargetIP
        SourceIP = $SpoofIP
        SourceMAC = $mac
    }
    Write-Host "[+] ARP packet spoofed to $TargetIP claiming $SpoofIP"
}

while ($true) {
    Spoof-ARP
    Start-Sleep -Milliseconds 500
}
