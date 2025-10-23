import 'package:teste_tecnico/data/models/character.dart';
import 'package:teste_tecnico/data/services/api_service.dart';

class CharacterRepository {
  CharacterRepository(this._api);
  final ApiService _api;

  Future<({List<Character> items, int? nextPage})> fetchCharacters({int page = 1}) async {
    final resp = await _api.get('character', query: {'page': page});
    final data = resp.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();
    final info = data['info'] as Map<String, dynamic>;
    final next = info['next'] as String?;
    int? nextPage;
    if (next != null && next.isNotEmpty) {
      final uri = Uri.parse(next);
      nextPage = int.tryParse(uri.queryParameters['page'] ?? '');
    }
    return (items: results, nextPage: nextPage);
  }
}
