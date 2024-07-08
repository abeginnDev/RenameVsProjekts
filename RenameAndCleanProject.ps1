# Custom Inputs
$mainFolderPath = Read-Host "Enter the path to the main folder (e.g., C:\MyFolder):"
$oldContent = Read-Host "Enter the old content to be replaced:"
$newContent = Read-Host "Enter the new content to replace the old one:"

# Counters for replaced files and contents
$replacedFiles = 0
$replacedContents = 0
$replacedFolders = 0

# Remove "bin" and "obj" folders and their contents, except in the "Resources" folder
$foldersToRemove = @("bin", "obj")
foreach ($folder in $foldersToRemove) {
    $folders = Get-ChildItem -Path $mainFolderPath -Filter $folder -Directory -Recurse | Where-Object { $_.FullName -notlike "*\Resources\*" }
    foreach ($item in $folders) {
        Remove-Item -Path $item.FullName -Recurse -Force
        Write-Host "Folder $($item.FullName) and its contents have been removed."
    }
}

# Section to be removed
$sectionToRemovePattern = @"
GlobalSection\(TeamFoundationVersionControl\) = preSolution[\s\S]*?EndGlobalSection
"@
Read-Host "Press Enter to remove the source control."

# Find the solution file in the specified directory
$solutionFilePaths = Get-ChildItem -Path $mainFolderPath -Filter *.sln -Recurse -File | Select-Object -ExpandProperty FullName

# File extensions to be removed
$fileExtensionsToRemove = "*.vspscc", "*.vssscc"

# Check if solution files were found
if ($solutionFilePaths.Count -eq 0) {
    Write-Host "No solution file found in the specified directory."
} else {
    foreach ($solutionFilePath in $solutionFilePaths) {
        # Read the content of the solution file
        $solutionContent = Get-Content $solutionFilePath -Raw
        
        # Remove the section from the content
        $newSolutionContent = $solutionContent -replace $sectionToRemovePattern, ""
        
        # Write the new content back to the solution file
        $newSolutionContent | Set-Content $solutionFilePath
        
        Write-Host "The section has been removed from the solution file $($solutionFilePath)."
    }
}

# Remove files with the specified extensions, except in the "Resources" folder
foreach ($extension in $fileExtensionsToRemove) {
    $filesToRemove = Get-ChildItem -Path $mainFolderPath -Filter $extension -Recurse -File | Where-Object { $_.FullName -notlike "*\Resources\*" }
    foreach ($fileToRemove in $filesToRemove) {
        Remove-Item $fileToRemove.FullName -Force
        Write-Host "File $($fileToRemove.FullName) has been removed."
    }
}

Read-Host "Press Enter to replace contents."

# Replace content in files, except in the "Resources" folder
Get-ChildItem -Path $mainFolderPath -File -Recurse | Where-Object { $_.DirectoryName -notlike "*\Resources\*" } | ForEach-Object {
    $content = Get-Content -Path $_.FullName
    $newContent = $content -replace $oldContent, $newContent
    Set-Content -Path $_.FullName -Value $newContent
    $replacedContents += ($content -match $oldContent).Count
}
Write-Host "Number of replaced contents: $replacedContents"
Read-Host "Press Enter to replace file names."

# Replace file names, except in the "Resources" folder
Get-ChildItem -Path $mainFolderPath -File -Recurse | Where-Object { $_.DirectoryName -notlike "*\Resources\*" } | ForEach-Object {
    $newName = $_.Name -replace $oldContent, $newContent
    Rename-Item -Path $_.FullName -NewName $newName
    $replacedFiles++
}
Write-Host "Number of replaced file names: $replacedFiles"
Read-Host "Press Enter to rename folders."

# Rename folders, except in the "Resources" folder
Get-ChildItem -Path $mainFolderPath -Directory -Recurse | Where-Object { $_.FullName -notlike "*\Resources\*" } | ForEach-Object {
    $newName = $_.Name -replace $oldContent, $newContent
    Rename-Item -Path $_.FullName -NewName $newName
    $replacedFolders++
}
Write-Host "Number of renamed folders: $replacedFolders"
Write-Host "Replacement completed!"

Read-Host "Press Enter to close the window."
