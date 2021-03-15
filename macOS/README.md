

## [How to hide the dock](https://apple.stackexchange.com/a/82084)

```
defaults write com.apple.dock autohide-delay -float 1000; killall Dock
# To restore the default behavior:
defaults delete com.apple.dock autohide-delay; killall Dock
```
