import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_thrones_characters/business_logic/cubit/charecters_cubit.dart';
import 'package:game_of_thrones_characters/constants/strings.dart';
import 'package:game_of_thrones_characters/data/models/characterModel.dart';
import 'package:game_of_thrones_characters/data/repository/characters_repository.dart';
import 'package:game_of_thrones_characters/data/web_services/characters_webServices.dart';
import 'package:game_of_thrones_characters/presentation/screens/characters_details_screen.dart';
import 'package:game_of_thrones_characters/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  // late QuotesCubit quotescubit;
  // late QuotesRepository quotesRepository;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
    // quotesRepository = QuotesRepository(QuotesWebServices());
    // quotescubit = QuotesCubit(quotesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const Character_Screen(),
                ));

      case charactersDetails:
        final character = settings.arguments as Character;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharactersDetailsScreen(
              character: character,
            ),
          ),
        );
    }
    return null;
  }
}
