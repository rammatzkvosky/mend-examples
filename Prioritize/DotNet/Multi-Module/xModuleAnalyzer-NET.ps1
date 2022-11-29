Set-Variable SEARCHDIR (Get-Location)
Set-Variable RELEASEDIR "*\bin\*"

Get-ChildItem -Include "*.csproj" -Recurse | Where-Object DirectoryName -NotLike *build* | Where-Object DirectoryName -NotLike *test* | Where-Object DirectoryName -NotLike *host* | Where-Object DirectoryName -NotLike *migration* | ForEach-Object {
     Write-Output "Found $_"
     Set-Variable CSPROJ $_.BaseName
     #Write-Output "Basename is $CSPROJ"
     Get-ChildItem -Recurse -Include *.dll | Where-Object FullName -like $RELEASEDIR$CSPROJ.dll | ForEach-Object {
        Write-Output $_.FullName >>multi-module.txt
     }
    }
    