import 'package:dio/dio.dart';
import 'package:game_of_thrones_characters/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;
  
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20), // 20 sec
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('Characters');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      return [];
    }
  }
}

// class QuotesWebServices{
//   late Dio dioquotes;
//   QuotesWebServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: quotesurl,
//       receiveDataWhenStatusError: true,
//       receiveTimeout: const Duration(seconds: 20),
//       connectTimeout: const Duration(seconds: 20), // 20 sec
//     );

//     dioquotes = Dio(options);
//   }

//   Future<List<dynamic>> getAllquotes() async {
//     try {
//       Response response =
//           await dioquotes.get('');
//       print(response.data.toString());
//       return response.data;
//     } catch (e) {
//       return [];
//     }
//   }


// }
