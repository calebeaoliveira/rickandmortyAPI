import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico/app_theme.dart';
import 'package:teste_tecnico/data/repositories/character_repository.dart';
import 'package:teste_tecnico/data/services/api_service.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_bloc.dart';
import 'package:teste_tecnico/logic/viewmodels/character_list/character_list_event.dart';
import 'package:teste_tecnico/ui/screens/character_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final api = ApiService();
  final repo = CharacterRepository(api);
  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});
  final CharacterRepository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => CharacterListBloc(repository)..add(CharacterListFetch()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const CharacterListPage(),
        ),
      ),
    );
  }
}
