import 'dart:math' as math;

import 'package:milktrace/data/models/session_placements.dart';

/// Okuyucusuz çiftlikte sıralı öneri (backend ADR 0136).
///
/// Hayvanlar sağımhaneye her gün aşağı yukarı aynı sırayla girer. Geçmiş
/// oturumlarda A, B'den `d` nokta önce (d = 1..3) sağıldıysa `C[A][B][d]`
/// sayılır; yeni oturum daha ağırdır (en yenisi 1, her eskisi × 0,85).
/// "Arkasından gelir" = canlı ekranda SONRAKİ nokta: sıra ekranın nokta
/// sırasıdır, sunucu sırayı bilmeye çalışmaz.
///
/// Web paneli aynı hesabı yapar; değiştirirsen ikisini birlikte değiştir.
class PlacementSequence {
  PlacementSequence._(this._spoutOrder, this._index, this._counts, this._last);

  /// Uzaklık sınırı: en yakın 3 dolu nokta bakılır.
  static const maxOffset = 3;

  /// Her eski oturumun ağırlık çarpanı.
  static const decay = 0.85;

  final List<String> _spoutOrder;
  final Map<String, int> _index;

  /// A → B → uzaklık → ağırlıklı sayı.
  final Map<String, Map<String, Map<int, double>>> _counts;

  /// En yeni oturumda nokta → hayvan.
  final Map<String, String> _last;

  /// [history] en yeni başta; [spoutOrder] canlı ekranın nokta sırası.
  factory PlacementSequence.build(
    List<String> spoutOrder,
    List<SessionPlacements> history,
  ) {
    final index = {
      for (var i = 0; i < spoutOrder.length; i++) spoutOrder[i]: i,
    };
    final counts = <String, Map<String, Map<int, double>>>{};
    for (var k = 0; k < history.length; k++) {
      final w = math.pow(decay, k).toDouble();
      final placed = [
        for (final p in history[k].placements)
          if (index[p.spoutId] case final i?) (i, p.animalId),
      ]..sort((a, b) => a.$1.compareTo(b.$1));
      for (var x = 0; x < placed.length; x++) {
        for (var y = x + 1; y < placed.length; y++) {
          final d = placed[y].$1 - placed[x].$1;
          if (d > maxOffset) break;
          if (d < 1) continue;
          final byB = counts.putIfAbsent(placed[x].$2, () => {});
          final byD = byB.putIfAbsent(placed[y].$2, () => {});
          byD[d] = (byD[d] ?? 0) + w;
        }
      }
    }
    final last = history.isEmpty
        ? const <String, String>{}
        : {for (final p in history.first.placements) p.spoutId: p.animalId};
    return PlacementSequence._(spoutOrder, index, counts, last);
  }

  /// Geçmiş yoksa öneri de yok.
  bool get isEmpty => _counts.isEmpty && _last.isEmpty;

  /// [spoutId] noktası için sıralı öneri: önündeki en yakın 3 dolu noktanın
  /// hayvanlarına göre puan. [current] bu oturumdaki nokta → hayvan;
  /// [eligible] sağmal ve seçilebilir hayvanlar. Zaten bir noktaya bağlı
  /// hayvan öneri olmaz. Puana göre azalan.
  List<Follower> followers(
    String spoutId,
    Map<String, String> current,
    Set<String> eligible,
  ) {
    final t = _index[spoutId];
    if (t == null) return const [];
    final taken = current.values.toSet();
    final score = <String, double>{};
    final leader = <String, (String, double)>{};
    for (var d = 1; d <= maxOffset; d++) {
      if (t - d < 0) break;
      final a = current[_spoutOrder[t - d]];
      if (a == null) continue;
      for (final MapEntry(key: b, value: byD)
          in (_counts[a] ?? const {}).entries) {
        final c = byD[d];
        if (c == null || taken.contains(b) || !eligible.contains(b)) continue;
        score[b] = (score[b] ?? 0) + c;
        if (c > (leader[b]?.$2 ?? 0)) leader[b] = (a, c);
      }
    }
    return [
      for (final MapEntry(key: b, value: s) in score.entries)
        if (s > 0) Follower(b, s, leader[b]!.$1),
    ]..sort((x, y) => y.score.compareTo(x.score));
  }

  /// "Grubu aynen onayla": boş noktalar ekran sırasıyla doldurulur — önce
  /// sıralı puanın en iyisi, yoksa en yeni oturumda bu noktadaki hayvan;
  /// bir hayvan bir kez. [rank] eşit puanlıları ayırır (küpe sırası).
  List<Proposal> propose(
    Map<String, String> current,
    Set<String> eligible, {
    int Function(String a, String b)? rank,
  }) {
    final working = {...current};
    final out = <Proposal>[];
    for (final spout in _spoutOrder) {
      if (working.containsKey(spout)) continue;
      final f = followers(spout, working, eligible);
      if (rank != null) {
        f.sort((x, y) {
          final s = y.score.compareTo(x.score);
          return s != 0 ? s : rank(x.animalId, y.animalId);
        });
      }
      String? pick;
      var reason = ProposalReason.sequence;
      if (f.isNotEmpty) {
        pick = f.first.animalId;
      } else if (_last[spout] case final prev?
          when eligible.contains(prev) && !working.containsValue(prev)) {
        pick = prev;
        reason = ProposalReason.previous;
      }
      if (pick == null) continue;
      working[spout] = pick;
      out.add(Proposal(spout, pick, reason));
    }
    return out;
  }
}

/// Sıralı öneri adayı.
class Follower {
  const Follower(this.animalId, this.score, this.leaderId);

  final String animalId;
  final double score;

  /// En çok katkıyı veren öndeki hayvan ("Genelde X'in arkasından gelir").
  final String leaderId;
}

/// Grup önerisinin neden seçildiği.
enum ProposalReason { sequence, previous }

/// Grup önerisinde bir nokta.
class Proposal {
  const Proposal(this.spoutId, this.animalId, this.reason);

  final String spoutId;
  final String animalId;
  final ProposalReason reason;
}
