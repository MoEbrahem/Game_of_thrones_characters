// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:game_of_thrones_characters/data/models/characterModel.dart';
import 'package:game_of_thrones_characters/data/repository/characters_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'charecters_state.dart';

class CharactersCubit extends Cubit<CharectersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharectersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllData().then(
      (characters) {
        emit(CharectersLoaded(characters));
        this.characters = characters;
      },
    );
    return characters;
  }
}

// class QuotesCubit extends Cubit<QuotesState> {
//   QuotesCubit(this.quotesRepository) : super(QuotesInitial()) ;

//   final QuotesRepository quotesRepository;

//   List quotes = [];

//   List getAllQuotes() {
//     quotesRepository.getAllquotes().then(
//       (quotes) {
//         emit(QuotesLoaded(quotes));
//       },
//     );
//     return quotes;
//   }
// }
