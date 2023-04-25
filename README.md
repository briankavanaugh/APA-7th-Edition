# APA 7th Edition for Microsoft Word

Until (unless) Microsoft gets around to adding a template for the latest version, this is the APA 7th Edition XSLT modified by Mike Slagle, plus the two additional fixes posted in the comments found [here](https://answers.microsoft.com/en-us/msoffice/forum/all/apa-7th-edition-in-ms-word/486fc70e-b7c7-40df-89bb-f8fc07169d40). This way, if other changes are needed, this file can be updated.

## How to Use

### Windows

#### Manual Method
1. Exit Word
2. Using Windows Explorer, copy the file APASeventhEdition.xsl to C:\Users\<your_user_name>\AppData\Roaming\Microsoft\Bibliography\Style 
3. Restart Word and from the References tab in Word, you should be able to choose APA7. 

#### Bat file method / Cmd method
1. Exit word
2. Copy the APASeventhEdition.bat file and allow it to run.
3. Restart Word and from the References tab in Word, you should be able to choose APA7. 

Note: The bat file simply runs the following line:
```
curl https://raw.githubusercontent.com/briankavanaugh/APA-7th-Edition/main/APASeventhEdition.xsl -o "%appdata%\Microsoft\Bibliography\Style\APASeventhEdition.xsl"
```



### MacOS

1. Exit Word
1. Using Finder, copy the file APASeventhEdition.xsl to *two* locations:
    1. HD/Applications/Microsoft Word.app/Contents/Resources/Style/ (note that you will have to right-click and "View Contents" on the app icon at HD/Applications/Microsoft Word.app/)
    1. HD/Users/\<your_user_name>/Library/Containers/com.microsoft.Word/Data/Library/Application Support/Microsoft/Office/Style/
1. Restart Word and from the References tab in Word, you should be able to choose APA7. 

## Disclaimer

(same as Mike's) I am only providing this file and the necessary location for it for education purposes. If any installations of MS Office are corrupted as a result of using this file, I am not responsible to address or repair any issues. 
