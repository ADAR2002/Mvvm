import 'package:bloc_ex1/constants/strings.dart';
import 'package:bloc_ex1/data/models/characters.dart';
import 'package:bloc_ex1/data/repository/characters_repository.dart';
import 'package:bloc_ex1/presentation/screens/characters_details.dart';
import 'package:bloc_ex1/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/characters_cubit.dart';
import 'data/API/characters_api.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersAPI());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generatorRouter(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: const CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final character = settings.arguments as Character;
            return BlocProvider(
              create: (BuildContext context) =>
                  CharactersCubit(charactersRepository),
              child: CharactersDetailsScreen(
                character: character,
              ),
            );
          },
        );
    }
    return null;
  }
}
