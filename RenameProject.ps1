# Custom inputs
$MainFolderPath = Read-Host "Enter the path to the main folder (e.g., C:\MyFolder):"
$OldContent = Read-Host "Enter the old content to be replaced:"
$NewContent = Read-Host "Enter the new content to replace the old content:"

# Counters for replaced files and contents
$ReplacedFiles = 0
$ReplacedContents = 0
$ReplacedFolders = 0

# Delete "bin" and "obj" folders and their contents, except in the "Resources" folder
$FoldersToRemove = @("bin", "obj")
foreach ($folder in $FoldersToRemove) {
    $folders = Get-ChildItem -Path $MainFolderPath -Filter $folder -Directory -Recurse | Where-Object { $_.FullName -notlike "*\Resources\*" }
    foreach ($item in $folders) {
        Remove-Item -Path $item.FullName -Recurse -Force
        Write-Host "Folder $($item.FullName) and its contents were removed."
    }
}

Read-Host "Press Enter to replace contents."

# Replace content in files, except in the "Resources" folder
Get-ChildItem -Path $MainFolderPath -File -Recurse | Where-Object { $_.DirectoryName -notlike "*\Resources\*" } | ForEach-Object {
    $content = Get-Content -Path $_.FullName
    $newContent = $content -replace $OldContent, $NewContent
    Set-Content -Path $_.FullName -Value $newContent
    $ReplacedContents += ($content -match $OldContent).Count
}
Write-Host "Number of replaced contents: $ReplacedContents"
Read-Host "Press Enter to replace filenames."

# Replace filenames, except in the "Resources" folder
Get-ChildItem -Path $MainFolderPath -File -Recurse | Where-Object { $_.DirectoryName -notlike "*\Resources\*" } | ForEach-Object {
    $newName = $_.Name -replace $OldContent, $NewContent
    Rename-Item -Path $_.FullName -NewName $newName
    $ReplacedFiles++
}
Write-Host "Number of replaced filenames: $ReplacedFiles"
Read-Host "Press Enter to rename folders."

# Rename folders, except in the "Resources" folder
Get-ChildItem -Path $MainFolderPath -Directory -Recurse | Where-Object { $_.FullName -notlike "*\Resources\*" } | ForEach-Object {
    $newName = $_.Name -replace $OldContent, $NewContent
    Rename-Item -Path $_.FullName -NewName $newName
    $ReplacedFolders++
}
Write-Host "Number of replaced folders: $ReplacedFolders"
Write-Host "Replacement completed!"

Read-Host "Press Enter to close the window."
