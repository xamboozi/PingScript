
$subnet = "192.168.1"
$start = 1
$end = 254
$ping = 1
$array = @()
while ($start -le $end) {
    $IP = "$subnet.$start"
    $Pingable = Test-Connection -ComputerName $IP -count 1 -Quiet 
    try {
        $DNSName = (Resolve-DnsName 192.168.1.92 -server 192.168.1.1 -DnsOnly -ErrorAction SilentlyContinue).Namehost
        }
    catch {
        $DNSName = "None"
        }

    $item = @{}
    $item = [pscustomobject]@{
    IP = $start
    Pingable = $Pingable
    DNSName = $DNSName
    NBName = $NBName
    }

    $item

    if (($item.pingable -eq $true) -or ($item.DNSName -eq $true) )
    {
        $array += $item
    }

    $start++
}

write-host "Active IP's"
$array | Format-Table