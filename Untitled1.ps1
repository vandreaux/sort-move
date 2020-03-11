$sourcePath = 'X:\DOCO\RAW\Logos'


Get-Childitem $sourcePath -File | Foreach-Object `
    {
     $target = -join($sourcePath,"\", $_.FullName.Substring($_.FullName.LastIndexOf("."), $_.FullName.Length - $_.FullName.LastIndexOf(".")).Substring(1))
     echo $target
     echo $_
     mkdir $target
     cd $sourcePath
     $filefix = $_.fullname.replace("[", "``[").replace("]", "``]")
     echo $filefix
     Move-Item $filefix -Destination $target
    }