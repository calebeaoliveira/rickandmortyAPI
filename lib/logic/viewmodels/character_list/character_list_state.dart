import 'package:equatable/equatable.dart';
import 'package:teste_tecnico/data/models/character.dart';

class CharacterListState extends Equatable {
  final List<Character> items;
  final bool loading;
  final bool loadingMore;
  final String? error;
  final int _page;
  final int? _nextPage;

  const CharacterListState({
    this.items = const [],
    this.loading = false,
    this.loadingMore = false,
    this.error,
    int page = 1,
    int? nextPage,
  })  : _page = page,
        _nextPage = nextPage;

  int get page => _page;
  int? get nextPage => _nextPage;

  CharacterListState copyWith({
    List<Character>? items,
    bool? loading,
    bool? loadingMore,
    String? error,
    int? page,
    int? nextPage,
  }) {
    return CharacterListState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error,
      page: page ?? _page,
      nextPage: nextPage ?? _nextPage,
    );
  }

  @override
  List<Object?> get props => [items, loading, loadingMore, error, _page, _nextPage];
}
