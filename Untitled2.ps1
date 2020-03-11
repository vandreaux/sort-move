$sourcePath = 'X:\Files\OMEGA'
// X:\Files\OMEGA\Downloads
 
 
Get-Childitem $sourcePath -File | Foreach-Object `
    {
     $calculatedExt = $_.FullName.Substring($_.FullName.LastIndexOf("."), $_.FullName.Length - $_.FullName.LastIndexOf(".")).Substring(1)
     $extPath = -join($sourcePath,"\", $calculatedExt)
     echo -join($extPath," ",$_);
     if (!(Test-Path -path $extPath)) { mkdir $extPath }
     cd $extPath
     $cleanFullName = $_.fullname.replace("[", "``[").replace("]", "``]")
     $cleanName = $_.name.replace("[", "``[").replace("]", "``]")
     $destination = -join($extPath,"\",$cleanName);
     if (!(Test-Path -path $destination)) {
        Move-Item $cleanFullName -Destination $extPath
     } else {
        $dup="";
        For ($i=0; $i -le 10; $i++) {
            $dup=$dup+"\!dup";
            $dupPath = -join($extPath,$dup);
            $destination = -join($dupPath,"\",$cleanName);
            if (!(Test-Path -path $destination)) {
                if (!(Test-Path -path $dupPath)) { mkdir $dupPath }
                Move-Item $cleanFullName -Destination $dupPath
                $i=10;
            }
        }

     }
    } 