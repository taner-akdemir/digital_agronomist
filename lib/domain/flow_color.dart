import 'package:json_annotation/json_annotation.dart';

/// Debi ve verim göstergelerinin rengi (§6.2, §6.3).
///
/// Değerler backend'in `spout.update` payload'ında gönderdiği stringlerle
/// birebir aynıdır; Go tarafında `common/milkrules.Color` ile eşleşir.
enum MilkColor {
  @JsonValue('green')
  green,
  @JsonValue('yellow')
  yellow,
  @JsonValue('red')
  red,

  /// Akış yok, eşleşme yok ya da cihaz çevrimdışı.
  @JsonValue('grey')
  grey,
}

/// Bir sağım noktasının anlık durumu.
enum SpoutState {
  /// Boşta: başlık takılı değil.
  @JsonValue('idle')
  idle,

  /// Sağım sürüyor.
  @JsonValue('milking')
  milking,

  /// Bu hayvanın sağımı kapandı.
  @JsonValue('done')
  done,

  @JsonValue('error')
  error,
}
