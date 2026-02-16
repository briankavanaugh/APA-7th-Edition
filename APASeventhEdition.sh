#!/bin/bash

# Constants
SOURCE_URL="https://raw.githubusercontent.com/briankavanaugh/APA-7th-Edition/main/APASeventhEdition.xsl"
LOCAL_DIR="/Library/Application Support/APAStyleTool"
LOCAL_FILE="$LOCAL_DIR/APASeventhEdition.xsl"
PLIST_FILE="/Library/LaunchDaemons/com.apastyle.copy.plist"

# Determine username and home directory
USERNAME=$(stat -f "%Su" /dev/console)
USER_HOME=$(dscl . -read /Users/$USERNAME NFSHomeDirectory | awk '{print $2}')

# Target paths
DESTINATION_PATH_1="/Applications/Microsoft Word.app/Contents/Resources/Style/APASeventhEdition.xsl"
DESTINATION_PATH_2="$USER_HOME/Library/Containers/com.microsoft.Word/Data/Library/Application Support/Microsoft/Office/Style/APASeventhEdition.xsl"

echo "Downloading and installing APA style file..."

# Create local folder and download the file
sudo mkdir -p "$LOCAL_DIR"
sudo curl -fsSL "$SOURCE_URL" -o "$LOCAL_FILE"

# Copy immediately to both destinations
sudo cp "$LOCAL_FILE" "$DESTINATION_PATH_1"
sudo mkdir -p "$(dirname "$DESTINATION_PATH_2")"
sudo cp "$LOCAL_FILE" "$DESTINATION_PATH_2"
echo "Initial file copy completed."

# Check for --persist flag
if [[ "$1" == "--persist" ]]; then
    echo "Setting up LaunchDaemon for persistence..."

    # Write LaunchDaemon plist with detailed comments
    sudo tee "$PLIST_FILE" > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

    <!-- Unique identifier for the daemon -->
    <key>Label</key>
    <string>com.apastyle.copy</string>

    <!-- The command to run: copy the local file to both Word destinations -->
    <key>ProgramArguments</key>
    <array>
        <!-- Execute the following shell command -->
        <string>/bin/bash</string>
        <string>-c</string>
        <!-- Actual copy command: from local file to system and user template paths -->
        <string>
            cp "$LOCAL_FILE" "$DESTINATION_PATH_1" &&
            mkdir -p "$(dirname "$DESTINATION_PATH_2")" &&
            cp "$LOCAL_FILE" "$DESTINATION_PATH_2"
        </string>
    </array>

    <!-- Run this job when the system loads the daemon (i.e. at boot) -->
    <key>RunAtLoad</key>
    <true/>

    <!-- Optional: path for stdout logging -->
    <key>StandardOutPath</key>
    <string>/var/log/apastylecopy.log</string>

    <!-- Optional: path for stderr logging -->
    <key>StandardErrorPath</key>
    <string>/var/log/apastylecopy.log</string>

</dict>
</plist>
EOF

    # Set ownership and permissions — required for launchd to accept it
    sudo chown root:wheel "$PLIST_FILE"
    sudo chmod 644 "$PLIST_FILE"

    # Load and enable the daemon
    sudo launchctl load -w "$PLIST_FILE"

    echo "LaunchDaemon installed and will run on each boot."
    echo "To remove, run: sudo launchctl unload -w $PLIST_FILE && sudo rm $PLIST_FILE"
    echo "To disable, run: sudo launchctl unload -w $PLIST_FILE"
    echo "Logs can be found at /var/log/apastylecopy.log"
    echo "To view logs, run: tail -f /var/log/apastylecopy.log"
else
    echo "No persistence flag given. Skipping LaunchDaemon setup."
fi
