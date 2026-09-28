import 'package:milktrace/data/models/team_member.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team_providers.g.dart';

/// İşletmenin kullanıcıları: sahipler üstte, sonra ada göre.
@riverpod
Future<List<TeamMember>> teamList(Ref ref) async {
  final list = [...await ref.watch(repositoryProvider).teamMembers()];
  int rank(TeamMember m) => m.role == 'tenant_owner' ? 0 : 1;
  list.sort((a, b) {
    final r = rank(a).compareTo(rank(b));
    if (r != 0) return r;
    final an = a.fullName.isEmpty ? a.email : a.fullName;
    final bn = b.fullName.isEmpty ? b.email : b.fullName;
    return an.toLowerCase().compareTo(bn.toLowerCase());
  });
  return List.unmodifiable(list);
}
