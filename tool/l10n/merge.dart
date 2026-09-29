// Arayüz metinlerini birleştirir (backend ADR 0093).
//
// Kaynak: lib/l10n/parts/<bölüm>_tr.arb ve <bölüm>_en.arb. Çıktı:
// lib/l10n/app_tr.arb ve app_en.arb (elle DÜZENLENMEZ), ardından
// `flutter gen-l10n`.
//
// Bölümlere ayrı dosya: her özellik kendi metnini kendi dosyasında tutar;
// tek dev ARB'de aynı anda çalışan iki değişiklik sürekli çakışırdı.
//
// Denetimler (hata = çıkış kodu 1):
// - aynı anahtar iki bölümde,
// - tr'de olup en'de olmayan (ya da tersi) anahtar,
// - yer tutucuları ({count} gibi) iki dilde farklı olan metin.
//
// Kullanım: dart run tool/l10n/merge.dart [--no-gen]
import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final dir = Directory('lib/l10n/parts');
  final merged = {'tr': <String, Object?>{}, 'en': <String, Object?>{}};
  final owner = <String, String>{};
  final errors = <String>[];

  final files = dir.listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  for (final f in files) {
    final name = f.uri.pathSegments.last;
    final m = RegExp(r'^(.+)_(tr|en)\.arb$').firstMatch(name);
    if (m == null) continue;
    final part = m.group(1)!;
    final lang = m.group(2)!;
    final Map<String, Object?> data;
    try {
      data = (jsonDecode(f.readAsStringSync()) as Map).cast<String, Object?>();
    } on FormatException catch (e) {
      errors.add('$name: geçersiz JSON: ${e.message}');
      continue;
    }
    for (final e in data.entries) {
      if (e.key.startsWith('@@')) continue;
      final key = e.key.startsWith('@') ? e.key.substring(1) : e.key;
      final prev = owner['$lang:$key'];
      if (prev != null && prev != part && !e.key.startsWith('@')) {
        errors.add('"$key" iki bölümde: $prev ve $part ($lang)');
      }
      owner['$lang:$key'] = part;
      merged[lang]![e.key] = e.value;
    }
  }

  Set<String> keys(String lang) =>
      merged[lang]!.keys.where((k) => !k.startsWith('@')).toSet();
  for (final k in keys('tr').difference(keys('en'))) {
    errors.add('"$k" İngilizcede yok');
  }
  for (final k in keys('en').difference(keys('tr'))) {
    errors.add('"$k" Türkçede yok');
  }
  // Yer tutucu: harfle başlayan ad, ardından "}" ya da "," (ICU çoğulu).
  // "=1{1 animal}" ya da "one{Add…}" gibi dal metinleri sayılmaz.
  final ph = RegExp(r'\{([A-Za-z_]\w*)\s*[},]');
  for (final k in keys('tr').intersection(keys('en'))) {
    Set<String> of(String lang) =>
        ph.allMatches('${merged[lang]![k]}').map((m) => m.group(1)!).toSet();
    final a = of('tr');
    final b = of('en');
    if (a.length != b.length || !a.containsAll(b)) {
      errors.add('"$k" yer tutucuları farklı: tr $a, en $b');
    }
  }

  if (errors.isNotEmpty) {
    stderr.writeln(errors.join('\n'));
    exit(1);
  }

  const encoder = JsonEncoder.withIndent('  ');
  for (final lang in ['tr', 'en']) {
    final sorted = <String, Object?>{'@@locale': lang};
    final plain = keys(lang).toList()..sort();
    for (final k in plain) {
      sorted[k] = merged[lang]![k];
      if (merged[lang]!.containsKey('@$k')) {
        sorted['@$k'] = merged[lang]!['@$k'];
      }
    }
    File(
      'lib/l10n/app_$lang.arb',
    ).writeAsStringSync('${encoder.convert(sorted)}\n');
  }
  stdout.writeln('${keys('tr').length} metin birleştirildi');

  if (args.contains('--no-gen')) return;
  // gen-l10n çevrilmemiş metin raporunu build/'e yazıyor; temiz klonda yok.
  Directory('build').createSync(recursive: true);
  final r = Process.runSync('flutter', ['gen-l10n'], runInShell: true);
  stdout.write(r.stdout);
  stderr.write(r.stderr);
  exit(r.exitCode);
}
