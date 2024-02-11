import 'package:game_of_thrones_characters/data/models/characterModel.dart';
import 'package:game_of_thrones_characters/data/web_services/characters_webServices.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(
    this.charactersWebServices,
  );

  Future<List<Character>> getAllData() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}

// class QuotesRepository {
//   QuotesWebServices quotesWebServices;

//   QuotesRepository(this.quotesWebServices);

//   Future<List> getAllquotes() async {
//     final charactersquotes = await quotesWebServices.getAllquotes();
//     return charactersquotes.map((quote) => Quotes.fromJson(quote)).toList();
//   }
// }
