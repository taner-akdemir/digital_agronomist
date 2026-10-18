import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/assistant.dart';
import 'package:milktrace/domain/assistant_history.dart';

AssistantMessage u(String t) => AssistantMessage(role: assistantUser, text: t);
AssistantMessage a(String t) => AssistantMessage(role: assistantRole, text: t);

/// n tam tur (soru + cevap).
List<AssistantMessage> turns(int n) => [
  for (var i = 0; i < n; i++) ...[u('soru $i'), a('cevap $i')],
];

void main() {
  test('geçmiş + yeni soru sırayla ve kullanıcıyla biter', () {
    final req = assistantRequest(turns(2), '  yeni soru  ');
    expect(req, hasLength(5));
    expect(req.last, u('yeni soru'));
    expect(validateAssistantRequest(req), isNull);
  });

  test('boş soru gönderilmez', () {
    expect(
      validateAssistantRequest(assistantRequest(const [], '   ')),
      AssistantHistoryIssue.empty,
    );
  });

  test('2000 karakteri aşan soru reddedilir, 2000 geçer', () {
    expect(validateAssistantRequest([u('x' * 2000)]), isNull);
    expect(
      validateAssistantRequest([u('x' * 2001)]),
      AssistantHistoryIssue.messageTooLong,
    );
  });

  test('19 mesaj sınırı: 10. soru geçer, 11. reddedilir', () {
    final ten = assistantRequest(turns(9), 'onuncu');
    expect(ten, hasLength(19));
    expect(validateAssistantRequest(ten), isNull);
    expect(assistantCanAskMore(turns(9)), isTrue);

    expect(assistantCanAskMore(turns(10)), isFalse);
    expect(
      validateAssistantRequest(assistantRequest(turns(10), 'on birinci')),
      AssistantHistoryIssue.tooManyMessages,
    );
  });

  test('toplam 20000 karakter sınırı', () {
    final long = [
      for (var i = 0; i < 5; i++) ...[u('x' * 1999), a('y' * 1999)],
    ];
    // 10 × 1999 = 19990; + 11 karakter → 20001.
    expect(
      validateAssistantRequest([
        ...long.sublist(0, 9),
        a('y' * 1999),
        u('z' * 11),
      ]),
      AssistantHistoryIssue.totalTooLong,
    );
    expect(
      validateAssistantRequest([
        ...long.sublist(0, 9),
        a('y' * 1999),
        u('z' * 10),
      ]),
      isNull,
    );
  });

  test('roller sırayla değilse ya da asistanla biterse badOrder', () {
    expect(
      validateAssistantRequest([u('a'), u('b')]),
      AssistantHistoryIssue.badOrder,
    );
    expect(
      validateAssistantRequest([a('merhaba'), u('soru')]),
      AssistantHistoryIssue.badOrder,
    );
    expect(
      validateAssistantRequest([u('soru'), a('cevap')]),
      AssistantHistoryIssue.badOrder,
    );
  });

  test('uzun asistan cevabı geri gönderilirken 2000 karaktere kırpılır', () {
    final req = assistantRequest([u('soru'), a('c' * 2600)], 'devam');
    expect(req[1].text, hasLength(2000));
    expect(validateAssistantRequest(req), isNull);
  });
}
