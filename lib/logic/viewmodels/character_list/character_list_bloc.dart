import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico/data/repositories/character_repository.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_event.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this._repository) : super(const CharacterListState()) {
    on<CharacterListFetch>(_onFetch);
    on<CharacterListLoadMore>(_onLoadMore);
  }

  final CharacterRepository _repository;

  Future<void> _onFetch(CharacterListFetch event, Emitter<CharacterListState> emit) async {
    emit(state.copyWith(loading: true, error: null, page: 1));
    try {
      final result = await _repository.fetchCharacters(page: 1);
      emit(state.copyWith(
        items: result.items,
        loading: false,
        page: 1,
        nextPage: result.nextPage,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Falha ao carregar personagens.'));
    }
  }

  Future<void> _onLoadMore(CharacterListLoadMore event, Emitter<CharacterListState> emit) async {
    if (state.loadingMore || state.nextPage == null) return;
    emit(state.copyWith(loadingMore: true));
    try {
      final nextPage = state.nextPage!;
      final result = await _repository.fetchCharacters(page: nextPage);
      emit(state.copyWith(
        items: [...state.items, ...result.items],
        loadingMore: false,
        page: nextPage,
        nextPage: result.nextPage,
      ));
    } catch (e) {
      emit(state.copyWith(loadingMore: false));
    }
  }
}
