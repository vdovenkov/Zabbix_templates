
Param(

    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript({Test-Path $_})]
    [Alias("StatusFile")]
    [string]$path_to_status_file,

    [parameter(Position = 1, Mandatory = $true)]
    [ValidateSet("DATE", "HOSTNAME", "VERSION", "UPSNAME", "CABLE", "DRIVER", "UPSMODE", "STARTTIME", "MODEL", "STATUS",
        "LINEV", "LOADPCT", "BCHARGE", "TIMELEFT", "MBATTCHG", "MINTIMEL", "MAXTIME", "MAXLINEV", "MINLINEV", "OUTPUTV",
        "SENSE", "DWAKE", "DSHUTD", "DLOWBATT", "LOTRANS", "HITRANS", "RETPCT", "ITEMP", "ALARMDEL", "BATTV",
        "LINEFREQ", "LASTXFER", "NUMXFERS", "TONBATT", "CUMONBATT", "XOFFBATT", "SELFTEST", "STESTI", "STATFLAG", "DIPSW",
        "REG1", "REG2", "REG3", "MANDATE", "SERIALNO", "BATTDATE", "NOMOUTV", "NOMBATTV", "EXTBATTS", "BADBATTS",
        "FIRMWARE")]
    [alias("i")]
    #[String]
	$item
)

$regex = ''
switch ($item) {
    'DATE' { $regex = "^DATE\s+:\s+(.*)" }
    'HOSTNAME' { $regex = "^HOSTNAME\s+:\s+(.*)" }
    'VERSION' { $regex = "^VERSION\s+:\s+(.*)" }
    'UPSNAME' { $regex = "^UPSNAME\s+:\s+(.*)" }
    'CABLE' { $regex = "^CABLE\s+:\s+(.*)" }
    'DRIVER' { $regex = "^DRIVER\s+:\s+(.*)" }
    'UPSMODE' { $regex = "^UPSMODE\s+:\s+(.*)" }
    'STARTTIME' { $regex = "^STARTTIME\s+:\s+(.*)" }
    'MODEL' { $regex = "^MODEL\s+:\s+(.*)" }
    'STATUS' { $regex = "^STATUS\s+:\s+(.*)" }
    'LINEV' { $regex = "^LINEV\s+:\s+(.*)" }
    'LOADPCT' { $regex = "^LOADPCT\s+:\s+(.*)" }
    'BCHARGE' { $regex = "^BCHARGE\s+:\s+(.*)" }
    'TIMELEFT' { $regex = "^TIMELEFT\s+:\s+(.*)" }
    'MBATTCHG' { $regex = "^MBATTCHG\s+:\s+(.*)" }
    'MINTIMEL' { $regex = "^MINTIMEL\s+:\s+(.*)" }
    'MAXTIME' { $regex = "^MAXTIME\s+:\s+(.*)" }
    'MAXLINEV' { $regex = "^MAXLINEV\s+:\s+(.*)" }
    'MINLINEV' { $regex = "^MINLINEV\s+:\s+(.*)" }
    'OUTPUTV' { $regex = "^OUTPUTV\s+:\s+(.*)" }
    'SENSE' { $regex = "^SENSE\s+:\s+(.*)" }
    'DWAKE' { $regex = "^DWAKE\s+:\s+(.*)" }
    'DSHUTD' { $regex = "^DSHUTD\s+:\s+(.*)" }
    'DLOWBATT' { $regex = "^DLOWBATT\s+:\s+(.*)" }
    'LOTRANS' { $regex = "^LOTRANS\s+:\s+(.*)" }
    'HITRANS' { $regex = "^HITRANS\s+:\s+(.*)" }
    'RETPCT' { $regex = "^RETPCT\s+:\s+(.*)" }
    'ITEMP' { $regex = "^ITEMP\s+:\s+(.*)" }
    'ALARMDEL' { $regex = "^ALARMDEL\s+:\s+(.*)" }
    'BATTV' { $regex = "^BATTV\s+:\s+(.*)" }
    'LINEFREQ' { $regex = "^LINEFREQ\s+:\s+(.*)" }
    'LASTXFER' { $regex = "^LASTXFER\s+:\s+(.*)" }
    'NUMXFERS' { $regex = "^NUMXFERS\s+:\s+(.*)" }
    'TONBATT' { $regex = "^TONBATT\s+:\s+(.*)" }
    'CUMONBATT' { $regex = "^CUMONBATT\s+:\s+(.*)" }
    'XOFFBATT' { $regex = "^XOFFBATT\s+:\s+(.*)" }
    'SELFTEST' { $regex = "^SELFTEST\s+:\s+(.*)" }
    'STESTI' { $regex = "^STESTI\s+:\s+(.*)" }
    'STATFLAG' { $regex = "^STATFLAG\s+:\s+(.*)" }
    'DIPSW' { $regex = "^DIPSW\s+:\s+(.*)" }
    'REG1' { $regex = "^REG1\s+:\s+(.*)" }
    'REG2' { $regex = "^REG2\s+:\s+(.*)" }
    'REG3' { $regex = "^REG3\s+:\s+(.*)" }
    'MANDATE' { $regex = "^MANDATE\s+:\s+(.*)" }
    'SERIALNO' { $regex = "^SERIALNO\s+:\s+(.*)" }
    'BATTDATE' { $regex = "^BATTDATE\s+:\s+(.*)" }
    'NOMOUTV' { $regex = "^NOMOUTV\s+:\s+(.*)" }
    'NOMBATTV' { $regex = "^NOMBATTV\s+:\s+(.*)" }
    'EXTBATTS' { $regex = "^EXTBATTS\s+:\s+(.*)" }
    'BADBATTS' { $regex = "^BADBATTS\s+:\s+(.*)" }
    'FIRMWARE' { $regex = "^FIRMWARE\s+:\s+(.*)" }
}
$output = (Select-String -path $path_to_status_file -pattern $regex | % { $_.Matches } | % { $_.groups[1].value })
Write-Output $output

# Пример использования
#.\zabbix_get.exe -s 127.0.0.1 -p 10051 --tls-connect psk --tls-psk-identity "PSK agent 001"  --tls-psk-file "C:\Program Files\Zabbix Agent\psk.key" -k ups.apc[UPSNAME]
