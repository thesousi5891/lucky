$ServersList = @(
    'usatrameuu016.atrame.deloitte.com'
    'usatrameuu015.atrame.deloitte.com'
    'usatrameuuxyz.atrame.deloitte.com'
)

$Result = $ServersList | ForEach-Object {
    $Server = $_
    $Data = [pscustomobject] @{
        Server = $server
        Output = $null
    }

    try {
        $Response = Invoke-Command -ComputerName $Server -ScriptBlock { &gpupdate /force } -ErrorAction Stop
        $Data.Output = "$Response" | Out-string
    } Catch {
        $Data.Output = $_.exception.message | Out-string
    }
    $Data
}

$Result | Export-Csv C:\temp\result.csv -NoTypeInformation
#Restart-Computer -ComputerName $ServersList -Verbose -Force

