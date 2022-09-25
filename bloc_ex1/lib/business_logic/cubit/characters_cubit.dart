import 'package:bloc/bloc.dart';
import 'package:bloc_ex1/data/models/characters.dart';
import 'package:bloc_ex1/data/models/quote.dart';
import 'package:bloc_ex1/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<Character> characters = [];

  void getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersLoaded(characters));
    });
  }

  void getQuotes(String nameCharacters) {
    charactersRepository.getQuote(nameCharacters).then(
      (quote) {
        emit(CharactersQuoteLoaded(quote));
      },
    );
  }
}
