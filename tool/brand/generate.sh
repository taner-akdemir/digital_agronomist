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
# Aynı kaynaktan aynı bayt çıksın: PNG'ye tarih ve metin parçaları yazılmaz,
# yoksa her üretim bütün ikonları "değişmiş" gösterirdi.
magick() { command magick "$@"; }
PNG_OPTS=(-strip -define png:exclude-chunks=date,time,tEXt,zTXt,iTXt)
render() { # svg → 1024 png (saydam zemin)
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --window-size=1024,1024 \
    --default-background-color=00000000 --screenshot="$TMP/$1.png" "file://$PWD/tool/brand/$1.svg" >/dev/null 2>&1
}
render icon; render foreground; render monochrome; render mark
RES=android/app/src/main/res

# Eski Android ikonu (48dp) ve uyarlanabilir katmanlar (108dp).
for d in mdpi:1 hdpi:1.5 xhdpi:2 xxhdpi:3 xxxhdpi:4; do
  n=${d%%:*}; s=${d##*:}
  px=$(python3 -c "print(round(48*$s))"); fg=$(python3 -c "print(round(108*$s))")
  magick "$TMP/icon.png" -resize ${px}x${px} "${PNG_OPTS[@]}" "$RES/mipmap-$n/ic_launcher.png"
  magick "$TMP/foreground.png" -resize ${fg}x${fg} "${PNG_OPTS[@]}" "$RES/mipmap-$n/ic_launcher_foreground.png"
  magick "$TMP/monochrome.png" -resize ${fg}x${fg} "${PNG_OPTS[@]}" "$RES/mipmap-$n/ic_launcher_monochrome.png"
  # Bildirim simgesi 24dp, beyaz siluet.
  np=$(python3 -c "print(round(24*$s))"); mkdir -p "$RES/drawable-$n"
  magick "$TMP/monochrome.png" -resize ${np}x${np} "${PNG_OPTS[@]}" "$RES/drawable-$n/ic_stat_milktrace.png"
done

# iOS: tam kare, SAYDAMLIK YOK (App Store reddeder).
IOS=ios/Runner/Assets.xcassets/AppIcon.appiconset
for f in "$IOS"/Icon-App-*.png; do
  b=$(basename "$f" .png); spec=${b#Icon-App-}; size=${spec%%@*}; size=${size%x*}; scale=${spec##*@}; scale=${scale%x}
  px=$(python3 -c "print(round($size*$scale))")
  magick "$TMP/icon.png" -resize ${px}x${px} -background '#1F4732' -alpha remove -alpha off "${PNG_OPTS[@]}" "$f"
done
# Uygulama içi işaret (üst çubuk, giriş ekranı): 1x/2x/3x.
mkdir -p assets/brand/2.0x assets/brand/3.0x
magick "$TMP/mark.png" -trim +repage -resize 48x48 -gravity center -background none -extent 48x48 "${PNG_OPTS[@]}" assets/brand/mark.png
magick "$TMP/mark.png" -trim +repage -resize 96x96 -gravity center -background none -extent 96x96 "${PNG_OPTS[@]}" assets/brand/2.0x/mark.png
magick "$TMP/mark.png" -trim +repage -resize 144x144 -gravity center -background none -extent 144x144 "${PNG_OPTS[@]}" assets/brand/3.0x/mark.png
rm -rf "$TMP"
echo "ikonlar üretildi"
