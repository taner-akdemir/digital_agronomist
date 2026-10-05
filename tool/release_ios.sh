#!/usr/bin/env bash
# App Store Connect / TestFlight için sürüm paketi (.ipa) — CLAUDE.md §7, §8.
#
#   tool/release_ios.sh    (API varsayılanı https://api.milktrace.com.tr/api/v1;
#                           başka ortam için MT_API_BASE=... verilir)
#
# REDDEDER: API adresi https değilse (tool/release.sh ile aynı gerekçe) ve
# Xcode'da imza ekibi seçilmemişse (DEVELOPMENT_TEAM boş — imzasız paketi
# App Store Connect kabul etmez; Apple Developer Program üyeliği gerekir).
#
# Yükleme: Xcode → Window → Organizer ya da Transporter ile .ipa'yı gönder,
# sonra App Store Connect → TestFlight. versionCode gibi build numarası
# (pubspec `+N`) her yüklemede ARTMALI.
set -euo pipefail
cd "$(dirname "$0")/.."

MT_API_BASE=${MT_API_BASE:-https://api.milktrace.com.tr/api/v1}
case "$MT_API_BASE" in
  https://*) ;;
  *) echo "MT_API_BASE https olmalı: $MT_API_BASE" >&2; exit 1 ;;
esac
grep -Eq 'DEVELOPMENT_TEAM = [A-Z0-9]{10};' ios/Runner.xcodeproj/project.pbxproj || {
  echo "Xcode'da imza ekibi seçilmemiş: Runner → Signing & Capabilities → Team" >&2; exit 1; }

version=$(awk '/^version:/{print $2}' pubspec.yaml)
echo "==> sürüm $version · API $MT_API_BASE"

flutter pub get >/dev/null
flutter analyze
flutter test
flutter build ipa --release --dart-define=MT_API_BASE="$MT_API_BASE"

ipa=$(ls build/ios/ipa/*.ipa)
echo "==> $ipa ($(du -h "$ipa" | cut -f1)) — Transporter ya da Xcode Organizer → App Store Connect → TestFlight"
