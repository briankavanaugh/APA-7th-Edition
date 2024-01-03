#!/bin/bash

# Define the source URL for the file
SOURCE_URL="https://raw.githubusercontent.com/briankavanaugh/APA-7th-Edition/main/APASeventhEdition.xsl"

# Get the current username
USERNAME=$(whoami)

# Define the destination paths
DESTINATION_PATH_1="/Applications/Microsoft Word.app/Contents/Resources/Style/APASeventhEdition.xsl"
DESTINATION_PATH_2="/Users/$USERNAME/Library/Containers/com.microsoft.Word/Data/Library/Application Support/Microsoft/Office/Style/APASeventhEdition.xsl"

# Download the file and place it in the first destination
sudo curl "$SOURCE_URL" -o "$DESTINATION_PATH_1"

# Check if the file was successfully downloaded
if [ -e "$DESTINATION_PATH_1" ]; then
    # If successful, also copy it to the second destination
    sudo cp "$DESTINATION_PATH_1" "$DESTINATION_PATH_2"
    echo "File placed in both locations successfully."
else
    echo "Failed to download the file."
fi
