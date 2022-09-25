import 'package:bloc_ex1/data/API/characters_api.dart';
import 'package:bloc_ex1/data/models/quote.dart';

import '../models/characters.dart';

class CharactersRepository {
  final CharactersAPI charactersAPI;

  CharactersRepository(this.charactersAPI);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersAPI.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
    // cubit ومن ثم تمرير البيانات الى ال  map الى  json قمنا ب استلام البيانات ومن ثم تحويلها من
  }

  Future<List<Quote>> getQuote(String nameCharacters) async {
    final characterQuote = await charactersAPI.getQuote(nameCharacters);
    return characterQuote
        .map((quotes) => Quote.fromjson(quotes))
        .toList();
    // cubit ومن ثم تمرير البيانات الى ال  map الى  json قمنا ب استلام البيانات ومن ثم تحويلها من
  }
}
