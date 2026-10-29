#!/bin/bash
# Ad-hoc signs an unsigned (flutter --no-codesign) archive with the project's
# entitlements so exportArchive keeps them (push, app groups).
set -e
arch=$1; proj=$2
app=$arch/Products/Applications/Runner.app
for f in "$app"/Frameworks/*; do codesign -f -s - "$f" 2>/dev/null; done
for x in "$app"/PlugIns/*.appex; do
  [ -e "$x" ] || continue
  n=$(basename "$x" .appex)
  for f in "$x"/Frameworks/*; do [ -e "$f" ] && codesign -f -s - "$f" 2>/dev/null; done
  codesign -f -s - --entitlements "$proj/ios/$n/$n.entitlements" "$x"
done
codesign -f -s - --entitlements "$proj/ios/Runner/Runner.entitlements" "$app"
