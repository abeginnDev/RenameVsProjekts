# RenameVsProjekts---

# Visual Studio Project Renaming Script

This PowerShell script is designed to help developers easily rename C# projects, such as MAUI or WPF projects, within Visual Studio. The script automates the process of replacing content within files, renaming files, and renaming folders, making it especially useful when rebranding or restructuring projects.

## Features

- **Delete Unnecessary Folders:** Automatically removes `bin` and `obj` folders and their contents, except within `Resources` folders.
- **Replace Content in Files:** Searches for and replaces specified old content with new content in all files, excluding those in `Resources` folders.
- **Rename Files:** Renames files by replacing specified old content with new content in the filenames, excluding those in `Resources` folders.
- **Rename Folders:** Renames folders by replacing specified old content with new content in the folder names, excluding those in `Resources` folders.

## Prerequisites

Before running the script, you need to set up your PowerShell environment to allow script execution and ensure you run the script with administrative privileges.

### 1. Enable Script Execution

To enable the execution of PowerShell scripts, you need to set the execution policy. Open PowerShell as an administrator and run the following command:

```powershell
Set-ExecutionPolicy RemoteSigned
```

You may need to confirm the change by typing `Y` and pressing Enter.

### 2. Run PowerShell as Administrator

To run the script with the necessary permissions, you need to open PowerShell as an administrator:

1. Click on the Start menu.
2. Type `powershell`.
3. Right-click on `Windows PowerShell` and select `Run as administrator`.

## How to Use

1. **Clone the Repository:**
   ```sh
   git clone https://github.com/yourusername/visual-studio-project-renaming.git
   cd visual-studio-project-renaming
   ```

2. **Run the Script:**
   Open a PowerShell terminal as an administrator and execute the script/ Right click "Run as Powershell Script":
   ```powershell
   .\RenameProject.ps1
   ```

3. **Follow the Prompts:**
   The script will prompt you to:
   - Enter the path to the main folder of your project.
   - Specify the old content to be replaced.
   - Specify the new content to replace the old content.

4. **Watch the Script Work:**
   The script will then:
   - Delete `bin` and `obj` folders.
   - Replace the specified old content with new content in all applicable files.
   - Rename files and folders accordingly.

5. **Completion:**
   The script will display the number of replaced contents, filenames, and folders upon completion.

## Example

Imagine you want to rename a project from "OldProject" to "NewProject":

- You will be prompted to enter the path to the main folder, such as `C:\Projects\OldProject`.
- Enter "OldProject" as the old content and "NewProject" as the new content.
- The script will handle the rest, updating all relevant files, filenames, and folder names.

## Notes

- Ensure you have a backup of your project before running the script.
- The script excludes changes in the `Resources` folder to preserve resource integrity.

## Contribution

Feel free to fork the repository and submit pull requests. Contributions are welcome!

## License

This project is licensed under the MIT License.

---
