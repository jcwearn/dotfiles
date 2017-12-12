### plist setup
- cp plist files in `LaunchDaemon` dir to `/System/Library/LaunchDaemons`
- For each file run `sudo launchctl load -F /System/Library/LaunchDaemons/FILENAME.plist`