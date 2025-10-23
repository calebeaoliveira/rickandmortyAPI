abstract class CharacterListEvent {}

class CharacterListFetch extends CharacterListEvent {
  CharacterListFetch({this.refresh = false});
  final bool refresh;
}

class CharacterListLoadMore extends CharacterListEvent {}
