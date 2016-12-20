'Name of the program.
InstallerName = "Shockwave 10 and 12 Xtras pack for Backlot"

'Set objects.
Set WScriptShell = CreateObject("WScript.Shell")
Set ScriptingFileSystemObject = CreateObject("Scripting.FileSystemObject")
Set objNetwork = CreateObject("Wscript.Network")

'Folders to copy.
CopyFolderS10 = "XtrasLib\Macromedia"
CopyFolderS12 = "XtrasLib\Adobe"

'Folder to install to.
TargetFolder = "C:\Users\" & objNetwork.UserName & "\AppData\LocalLow\"

'Ask to install. If not OK, create message and quit.
QuestionBox1 = MsgBox ("Ready to install " & InstallerName & " for the current computer user." & Vbcrlf & "Click OK to continue or Cancel to exit the installation." & Vbcrlf & "Please note that this installer is intended to bugfix Xtras issues with Shockwave 10 and 12 only. Also, please note that this installer has only been tested on Shockwave 10.4 and 12.0. If you are running a version of Shockwave older than 10, it is highly recommended to update your Shockwave player. To avoid any Xtra issues, it is highly recommended to install Shockwave 11.", 1, InstallerName & " Installer")
If QuestionBox1 <> vbOK Then
MsgBox "Installation cancelled.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Ask for path to install and provide default location.
CopyToPath = InputBox("Input the path to your user's LocalLow directory. If it is as below, click OK. Otherwise, enter the correct path below, then click OK.", InstallerName & " Installer", TargetFolder)

'If Cancel was clicked, or nothing was entered, create message and exit.
If CopyToPath = "" Then
MsgBox "Installation cancelled.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Get current directory.
WScriptShell.CurrentDirectory = ScriptingFileSystemObject.GetParentFolderName(Wscript.ScriptFullName)

'Set current directory variable.
CurrentDirectory = WScriptShell.CurrentDirectory

'Set paths to copy from.
CopyFromPathS10 = CurrentDirectory & "\" & CopyFolderS10
CopyFromPathS12 = CurrentDirectory & "\" & CopyFolderS12

'Set objects.
Set ShellApplication = CreateObject("Shell.Application")
Set NameSpaceCopyPath = ShellApplication.NameSpace(CopyToPath)

'Check if the folders exist to copy from, else create an error message and exit.
If Not ScriptingFileSystemObject.FolderExists(CopyFromPathS10) Then
If ScriptingFileSystemObject.FolderExists(CopyFromPathS12) Then
MsgBox "Could not find folder: " & CopyFolderS10 & ". " & Vbcrlf & "Check the paths and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If
If Not ScriptingFileSystemObject.FolderExists(CopyFromPathS12) Then
MsgBox "Could not find folders: " & CopyFolderS10 & ", " & CopyFolderS12 & ". " & Vbcrlf & "Check the paths and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If
End If

If Not ScriptingFileSystemObject.FolderExists(CopyFromPathS12) Then
MsgBox "Could not find folder: " & CopyFolderS12 & ". " & Vbcrlf & "Check the paths and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If

'Copy the folders to install.
If ScriptingFileSystemObject.FolderExists(CopyToPath & "\Macromedia\Shockwave Player\") Then
NameSpaceCopyPath.CopyHere CopyFromPathS10, 16
End If

If ScriptingFileSystemObject.FolderExists(CopyToPath & "\Adobe\Shockwave Player 12\") Then
NameSpaceCopyPath.CopyHere CopyFromPathS12, 16
End If

If Not ScriptingFileSystemObject.FolderExists(CopyToPath & "\Macromedia\Shockwave Player\") Then
If Not ScriptingFileSystemObject.FolderExists(CopyToPath & "\Adobe\Shockwave Player 12\") Then
MsgBox "It appears that you don't have either Shockwave 10 or 12 installed, or you have incorrectly specified the path to your user's LocalLow folder. Please check the path and try again.", 0, InstallerName & " Installer"
WScript.Quit
End If
End If

'Create final message box, then exit.
MsgBox "Xtras patch complete. If the game still won't run in your browser, please contact us at LMPbugs@gmail.com, specifying the error that occured and the version of Shockwave that you have installed.", 0, InstallerName & " Installer"
WScript.quit