// app,dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'src/presentation/list/bloc/character_list_bloc.dart';
import 'src/di/injector.dart';
import 'src/domain/usecases/get_characters_page.dart';
import 'src/presentation/list/pages/character_list_page.dart';
import 'package:go_router/go_router.dart';
import 'src/presentation/details/pages/character_details_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => BlocProvider(
            create: (_) => CharacterListBloc(sl<GetCharactersPage>())..add(CharactersFetched()),
            child: const CharacterListPage(),
          ),
        ),
        GoRoute(
          path: '/character/:id',
          builder: (ctx, state) {
            final character = state.extra as Character;
            return CharacterDetailsPage(character: character);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Characterpedia',
      routerConfig: router,
      theme: ThemeData(useMaterial3: true),
    );
  }
}