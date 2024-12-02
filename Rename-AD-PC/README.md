#Rename-Remote-PC
This script will rename computers on an Active Directory Domain.

##Table of Contents
-[Prerequisites](#prerequisites)
-[Usage](#usage)
-[Troubleshooting](#troubleshooting)

##Prerequisites

1. Set Execution Policy to allow the usage of Powershell Scripts.
   i.    Open a PowerShell Terminal.
   ii.   Enter the following:
         Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
   iii.  Press A for Yes to All.
   iv.   Confirm setting change by typing the following:
         Get-ExecutionPolicy

2. Fill Out the names.cvs file. For all the computers you want to rename, do the following:
   i.    Under OldName, enter the current name of the computer you want to rename.
   ii.   Under NewName, enter the new name you want the computer to have.

##Usage

1. Make sure the .ps1 file and the names.csv are in the same folder.
2. Right-Click on the .ps1 file, and select Run as Administrator.
3. Enter Domain Admin Credentials when Prompted.
4. Status should display on the terminal, and be saved to a log file created and placed in the same folder the script is run from.
5. When it is completed, a new .csv file is created with all the computers that failed to be renamed.
6. When you're ready to try again, rename the new csv to names.csv before running the script again.

##Troubleshooting

If the script won't run because it there is no license/ it was not written on your computer:
Copy the code of the powershell script to a new file. (I have not purchased a license to authenticate the script, and powershell won't let the script run unless it thinks you wrote it.)
   i.    Open the Rename-AD-PC.ps1 file in a text editor such as Notepad.
   ii.   With the script open in notepad, press CTRL + A and then CTRL + C. This will select all the text, and copy it.
   iii.  Create a new file in Notepad, and press CTRL + V to paste the copied code.
   iv.   Save the file to the same folder that has the names.csv file. Give it a name that ends with .ps1, select "all files" from the dropdown, then select save.
   v.    Run the ps1 file you saved as admin. 
