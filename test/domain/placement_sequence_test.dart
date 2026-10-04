import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/session_placements.dart';
import 'package:milktrace/domain/placement_sequence.dart';

SessionPlacements _s(int k, List<String?> animals) => SessionPlacements(
  sessionId: 's$k',
  startedAt: DateTime.utc(2026, 10, 1).subtract(Duration(days: k)),
  placements: [
    for (var i = 0; i < animals.length; i++)
      if (animals[i] case final a?) Placement(spoutId: 'p$i', animalId: a),
  ],
);

void main() {
  const order = ['p0', 'p1', 'p2', 'p3', 'p4'];
  const all = {'A', 'B', 'C', 'D', 'E'};

  test('arkasından gelen en üstte; yeni oturum daha ağır', () {
    final seq = PlacementSequence.build(order, [
      _s(0, ['A', 'B', 'C']),
      _s(1, ['A', 'C', 'B']),
    ]);
    final f = seq.followers('p1', {'p0': 'A'}, all);
    expect(f.map((x) => x.animalId), ['B', 'C']);
    expect(f.first.score, closeTo(1, 1e-9));
    expect(f.last.score, closeTo(0.85, 1e-9));
    expect(f.first.leaderId, 'A');
  });

  test('iki nokta öndeki hayvan da sayılır (uzaklık 2)', () {
    final seq = PlacementSequence.build(order, [
      _s(0, ['A', 'B', 'C']),
    ]);
    // p1 boş; p2 için A'nın 2 arkası C.
    final f = seq.followers('p2', {'p0': 'A'}, all);
    expect(f.single.animalId, 'C');
  });

  test(
    'bağlı ya da seçilemez hayvan öneri olmaz; önde dolu nokta yoksa boş',
    () {
      final seq = PlacementSequence.build(order, [
        _s(0, ['A', 'B', 'C']),
      ]);
      expect(seq.followers('p1', {'p0': 'A', 'p4': 'B'}, all), isEmpty);
      expect(seq.followers('p1', {'p0': 'A'}, {'A', 'C'}), isEmpty);
      expect(seq.followers('p1', const {}, all), isEmpty);
    },
  );

  test('grup önerisi: sıra, önceki noktaya düşme, bir hayvan bir kez', () {
    final seq = PlacementSequence.build(order, [
      _s(0, ['A', 'B', 'C', null, 'E']),
    ]);
    final p = seq.propose({'p0': 'A'}, all);
    expect(
      [for (final x in p) '${x.spoutId}:${x.animalId}'],
      ['p1:B', 'p2:C', 'p4:E'],
    );
    expect(p[0].reason, ProposalReason.sequence);
    expect(p.map((x) => x.animalId).toSet().length, p.length);
  });

  test('önceki sağımdaki hayvan seçilemezse önerilmez', () {
    final seq = PlacementSequence.build(order, [
      _s(0, [null, null, null, null, 'E']),
    ]);
    final p = seq.propose(const {}, {'A'});
    expect(p, isEmpty);
    final q = seq.propose(const {}, {'E'});
    expect(q.single.reason, ProposalReason.previous);
  });
}
