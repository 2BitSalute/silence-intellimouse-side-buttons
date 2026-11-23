## Credits

The code was produced mostly by Gemini 4 Hydrogen (Google), knowledge cutoff March 2026.

Some of the logging added by me, README text/structure added by me, code/command snippets listed in the README suggested by Gemini and edited by me.

## Accessibility permissions

You have to grant Device Control and Data Access permissions to the IDE once.

If you're running as a LaunchAgent, you have to give permissions to the app binary itself and repeat the process every time you recompile it.

## LaunchAgent

(NOTE: I have not see the logging to the specified PLIST paths work yet, but didn't pursue the issue further as the app seems to work OK anyway for now.)

To set up a launch agent (check the path, though):

``` zsh
mkdir -p ~/Library/LaunchAgents

cat <<EOF > ~/Library/LaunchAgents/com.user.blocksidebuttons.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://apple.com">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.blocksidebuttons</string>
    <key>ProgramArguments</key>
    <array>
        <string>$HOME/Documents/silence-intellimouse-side-buttons/block_side_buttons</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$HOME/Documents/silence-intellimouse-side-buttons/blocksidebuttons.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/Documents/silence-intellimouse-side-buttons/blocksidebuttons.err</string>
</dict>
</plist>
EOF
```

## Initial launch

``` zsh
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.blocksidebuttons.plist
```

## To relaunch (if fixes are needed)

``` zsh
launchctl kickstart -k gui/$(id -u)/com.user.blocksidebuttons
```
