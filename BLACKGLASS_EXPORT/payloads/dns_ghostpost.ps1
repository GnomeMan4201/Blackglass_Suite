# DNS Ghostpost - Fakes DNS queries to mimic internal traffic
$domains = @("intra.domain", "vault.local", "secret.internal")
foreach ($d in $domains) {
  Resolve-DnsName $d -Server 8.8.8.8 | Out-File "$env:TEMP\\dns_ghost.log" -Append
}
