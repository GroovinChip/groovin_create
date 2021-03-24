#!/bin/sh
test -f groovin_create.dmg && rm groovin_create.dmg
create-dmg \
  --volname "Groovin Create Installer" \
  --volicon "./assets/groovin_create_installer.icns" \
  --window-pos 200 120 \
  --window-size 800 530 \
  --icon-size 130 \
  --text-size 14 \
  --icon "groovin_create.app" 260 250 \
  --hide-extension "groovin_create.app" \
  --app-drop-link 540 250 \
  --hdiutil-quiet \
  "build/macos/Build/Products/Release/groovin_create.dmg" \
  "build/macos/Build/Products/Release/groovin_create.app"