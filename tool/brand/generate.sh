#!/usr/bin/env bash
# Uygulama ikonlarını tool/brand/*.svg'den üretir. Gerekenler: Google Chrome
# (SVG'yi doğru çizer; ImageMagick'in kendi çizicisi çizgileri kaybediyor)
# ve ImageMagick (boyutlandırma).
#
#   tool/brand/generate.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
CHROME=${CHROME:-"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"}
TMP=$(mktemp -d)
render() { # svg → 1024 png (saydam zemin)
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1024,1024 \
    --default-background-color=00000000 --screenshot="$TMP/$1.png" "file://$PWD/tool/brand/$1.svg" >/dev/null 2>&1
}
render icon; render foreground; render monochrome
RES=android/app/src/main/res

# Eski Android ikonu (48dp) ve uyarlanabilir katmanlar (108dp).
for d in mdpi:1 hdpi:1.5 xhdpi:2 xxhdpi:3 xxxhdpi:4; do
  n=${d%%:*}; s=${d##*:}
  px=$(python3 -c "print(round(48*$s))"); fg=$(python3 -c "print(round(108*$s))")
  magick "$TMP/icon.png" -resize ${px}x${px} "$RES/mipmap-$n/ic_launcher.png"
  magick "$TMP/foreground.png" -resize ${fg}x${fg} "$RES/mipmap-$n/ic_launcher_foreground.png"
  magick "$TMP/monochrome.png" -resize ${fg}x${fg} "$RES/mipmap-$n/ic_launcher_monochrome.png"
  # Bildirim simgesi 24dp, beyaz siluet.
  np=$(python3 -c "print(round(24*$s))"); mkdir -p "$RES/drawable-$n"
  magick "$TMP/monochrome.png" -resize ${np}x${np} "$RES/drawable-$n/ic_stat_milktrace.png"
done

# iOS: tam kare, SAYDAMLIK YOK (App Store reddeder).
IOS=ios/Runner/Assets.xcassets/AppIcon.appiconset
for f in "$IOS"/Icon-App-*.png; do
  b=$(basename "$f" .png); spec=${b#Icon-App-}; size=${spec%%@*}; size=${size%x*}; scale=${spec##*@}; scale=${scale%x}
  px=$(python3 -c "print(round($size*$scale))")
  magick "$TMP/icon.png" -resize ${px}x${px} -background '#1F4732' -alpha remove -alpha off "$f"
done
rm -rf "$TMP"
echo "ikonlar üretildi"
