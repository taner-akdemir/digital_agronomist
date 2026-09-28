#!/usr/bin/env bash
# Play Console dahili test kanalı için sürüm paketi (.aab) — CLAUDE.md §8.
#
#   MT_API_BASE=https://api.<alan-adı>/api/v1 tool/release.sh
#
# REDDEDER: anahtar yoksa (debug imzalı paketi Play kabul etmez) ve API adresi
# https değilse (sürüm derlemesi düz http'ye izin vermez; varsayılan
# 10.0.2.2/localhost yalnızca geliştirme içindir — sessizce oraya derlenmiş
# bir paket çiftçinin telefonunda hiçbir yere bağlanamazdı).
set -euo pipefail
cd "$(dirname "$0")/.."

: "${MT_API_BASE:?MT_API_BASE gerekli, ör. https://api.example.com/api/v1}"
case "$MT_API_BASE" in
  https://*) ;;
  *) echo "MT_API_BASE https olmalı: $MT_API_BASE" >&2; exit 1 ;;
esac
grep -q '^storeFile=' android/key.properties 2>/dev/null || {
  echo "android/key.properties yok ya da eksik — CLAUDE.md §8'deki keytool adımı" >&2; exit 1; }

version=$(awk '/^version:/{print $2}' pubspec.yaml)
echo "==> sürüm $version · API $MT_API_BASE"

flutter pub get >/dev/null
flutter analyze
flutter test
flutter build appbundle --release --dart-define=MT_API_BASE="$MT_API_BASE"

aab=build/app/outputs/bundle/release/app-release.aab
# İmzanın yükleme anahtarı olduğunu doğrula (debug değil).
if jarsigner -verify -verbose -certs "$aab" 2>/dev/null | grep -q "CN=Android Debug"; then
  echo "HATA: paket debug anahtarıyla imzalanmış" >&2; exit 1
fi
echo "==> $aab ($(du -h "$aab" | cut -f1)) — Play Console → Test → Dahili test → Yeni sürüm"
