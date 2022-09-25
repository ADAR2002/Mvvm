import 'package:bloc_ex1/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersAPI {
  late Dio dio;

  CharactersAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(
          'characters'); // تبعها list حملنا كل الكاريكترز من النت ورجعنا ال
      return response.data; //ارجاع ال داتا تبعي
    } catch (error) {
      return []; //منشان ما يوقف التطبيق

    }
  }

  Future<List<dynamic>> getQuote(String nameCharacters) async {
    try {
      Response response = await dio.get(
          'quote',queryParameters: {'author':nameCharacters}); // تبعها list حملنا كل الكاريكترز من النت ورجعنا ال
      return response.data; //ارجاع ال داتا تبعي
    } catch (error) {
      return []; //منشان ما يوقف التطبيق
    }
  }
}
