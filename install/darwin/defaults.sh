#!/usr/bin/env bash

# Inspired by: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

info "Changing the macOS defaults..."

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change.
osascript -e 'tell application "System Preferences" to quit'

# --- General ------------------------------------------------------------------

# Increase window resize speed for Cocoa applications.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand the save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand the print panel by default.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Automatically quit the printer app once the print jobs complete.
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable smart quotes and dashes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- SSD tweaks ---------------------------------------------------------------

# Disable hibernation.
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space.
sudo rm /private/var/vm/sleepimage

# Create a zero-byte file instead...
sudo touch /private/var/vm/sleepimage

# ...and make sure it can't be rewritten.
sudo chflags uchg /private/var/vm/sleepimage

# Disable the sudden motion sensor as it’s not useful for SSDs.
sudo pmset -a sms 0

# --- Trackpad, mouse, keyboard, Bluetooth accessoires, and input --------------

# Trackpad: enable tap to click for this user and for the login screen.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Enable natural style scrolling.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Enable full keyboard access for all controls (e.g. enable Tab in modal
# dialogs).
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast key repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Set language and text formats.
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone.
sudo systemsetup -settimezone "Europe/Amsterdam" >/dev/null

# Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# --- Screen -------------------------------------------------------------------

# Require password immediately after sleep or screen saver begins.
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write com.apple.screensaver askForPassword -int 1

# Save screenshots to the desktop.
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format.
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots.
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs.
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# --- Finder -------------------------------------------------------------------

# Hide all icons on the desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

# Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library directory.
chflags nohidden ~/Library

# Show the /Volumes directory.
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”.
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

# --- Dock and Dashboard -------------------------------------------------------

# Disable Dashboard.
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space.
defaults write com.apple.dock dashboard-in-overlay -bool true

# Set the icon size of Dock items to 16 pixels.
defaults write com.apple.dock tilesize -int 16

# Minimize windows into their application's icon.
defaults write com.apple.dock minimize-to-application -bool true

# Speed up Misson Control animations.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Reset the Dock.
defaults write com.apple.dock persistent-apps -array

# Set the apps in the Dock.
DOCK_APPS=(
    "Launchpad"
    "Spotify"
    "iTunes"
    "Telegram"
    "Safari"
    "iTerm"
    "Mail"
    "Tweetbot"
    "Calendar"
    "System Preferences"
)

IFS=""

for app in ${DOCK_APPS[@]}; do
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${app}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

# --- Safari and WebKit --------------------------------------------------------

# Press Tab to highlight each item on a web page.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true

# Show the full URL in the address bar.
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading.
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Disable Safari’s thumbnail cache for History and Top Sites.
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Add a context menu item for showing the Web Inspector in web views.
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking.
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct.
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill.
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false

# Warn about fraudulent websites.
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
defaults write com.apple.Safari WebKitPluginsEnabled -bool false

# Disable Java.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari WebKitJavaEnabled -bool false

# Block pop-up windows.
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”.
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically.
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# --- Mail ---------------------------------------------------------------------

# Copy email addresses as `foo@example.com`.
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable inline attachments (just show the icons).
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# --- Spotlight ----------------------------------------------------------------

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Make sure indexing is enabled for the main volume.
sudo mdutil -i on / >/dev/null

# --- Time Machine -------------------------------------------------------------

# Prevent Time Machine from prompting to use new hard drives as backup volume.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups.
hash tmutil &> /dev/null && sudo tmutil disablelocal

# --- Activity Monitor ---------------------------------------------------------

# Show the main window when launching Activity Monitor.
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor.
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage.
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# --- App Store ----------------------------------------------------------------

# Enable the automatic update check.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background.
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates.
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs.
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update.
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates.
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

# --- Photos -------------------------------------------------------------------

# Prevent Photos from opening automatically when devices are plugged in.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# --- Messages -----------------------------------------------------------------

# Disable automatic emoji substitution (i.e. use plain text smileys).
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

# --- Google Chrome ------------------------------------------------------------

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Disable the all too sensitive backswipe on trackpads.
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse.
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog.
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
defaults write com.google.Chrome DisablePrintPreview -bool true

# Expand the print dialog by default.
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

# --- Opera --------------------------------------------------------------------

# Expand the print dialog by default.
defaults write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true
defaults write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true

# --- Tweetbot -----------------------------------------------------------------

# Bypass the annoyingly slow t.co URL shortener
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

# --- Kill affected applications -----------------------------------------------

for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "Google Chrome" \
        "Google Chrome Canary" "Mail" "Messages" "Opera" "Photos" "Safari" \
        "SystemUIServer" "Tweetbot"; do
	killall "${app}" &>/dev/null
done

success "Finished changing the macOS defaults."
