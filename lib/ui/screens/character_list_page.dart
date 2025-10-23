import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_bloc.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_event.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_state.dart';
import 'package:teste_tecnico/ui/screens/character_detail_page.dart';
import 'package:teste_tecnico/ui/widgets/character_card.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    if (offset > (max - 400)) {
      context.read<CharacterListBloc>().add(CharacterListLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: BlocBuilder<CharacterListBloc, CharacterListState>(
        builder: (context, state) {
          if (state.loading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error!),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => context.read<CharacterListBloc>().add(CharacterListFetch()),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CharacterListBloc>().add(CharacterListFetch(refresh: true));
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length + (state.loadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final c = state.items[index];
                return CharacterCard(
                  character: c,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CharacterDetailPage(character: c)),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
