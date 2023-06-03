case $@ in
"FaceTime")
  icon_result="󰱻"
  ;;
"Messages")
  icon_result="󰍡"
  ;;
"Tweetbot" | "Twitter")
  icon_result=""
  ;;
"VLC")
  icon_result="󰕼"
  ;;
"Emacs")
  icon_result=""
  ;;
"Thunderbird")
  icon_result=""
  ;;
"Notes")
  icon_result=""
  ;;
"Spark")
  icon_result=""
  ;;
"GitHub Desktop")
  icon_result="󰊢"
  ;;
"App Store")
  icon_result=""
  ;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
  icon_result=""
  ;;
"zoom.us")
  icon_result="󰬡"
  ;;
"Color Picker")
  icon_result="󰃉"
  ;;
"Microsoft Word")
  icon_result="󰈭"
  ;;
"Neovide" | "MacVim" | "Vim" | "VimR")
  icon_result=""
  ;;
"Sublime Text")
  icon_result=""
  ;;
"PomoDone App")
  icon_result=""
  ;;
"WhatsApp")
  icon_result=""
  ;;
"Parallels Desktop")
  icon_result="󰜨"
  ;;
"VMware Fusion")
  icon_result=""
  ;;
"Microsoft Excel")
  icon_result="󰈜"
  ;;
"Microsoft PowerPoint")
  icon_result="󰈨"
  ;;
"Numbers")
  icon_result=""
  ;;
"Default")
  icon_result="󰋶"
  ;;
"Bear")
  icon_result="󱣻"
  ;;
"Airmail")
  icon_result=""
  ;;
"Firefox Developer Edition" | "Firefox Nightly")
  icon_result=""
  ;;
"Trello")
  icon_result="󰔲"
  ;;
"Notion")
  icon_result="Nt"
  ;;
"Calendar" | "Fantastical")
  icon_result="󰃭"
  ;;
"Xcode")
  icon_result="󰬟"
  ;;
"Slack")
  icon_result=""
  ;;
"System Preferences" | "System Settings")
  icon_result=""
  ;;
"Discord" | "Discord Canary" | "Discord PTB")
  icon_result="󰙯"
  ;;
"Firefox")
  icon_result=""
  ;;
"Skype")
  icon_result=""
  ;;
"Dropbox")
  icon_result=""
  ;;
"Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件" | "Outlook")
  icon_result=""
  ;;
"Safari" | "Safari Technology Preview")
  icon_result=""
  ;;
"Telegram")
  icon_result=""
  ;;
"Keynote")
  icon_result="K"
  ;;
"Spotlight")
  icon_result="󰓈"
  ;;
"Music")
  icon_result="󰎄"
  ;;
"Pages")
  icon_result="P"
  ;;
"IntelliJ IDEA")
  icon_result=""
  ;;
"Finder")
  icon_result="󰀶"
  ;;
"Zeplin")
  icon_result="ZP"
  ;;
"Alacritty" | "Hyper" | "iTerm2" | "kitty" | "Terminal" | "WezTerm")
  icon_result=""
  ;;
"Tor Browser")
  icon_result="TB"
  ;;
"Sketch")
  icon_result="SK"
  ;;
*)
  icon_result=""
  ;;
esac
echo $icon_result
