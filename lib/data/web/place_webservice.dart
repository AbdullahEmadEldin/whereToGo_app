import 'package:dio/dio.dart';
import 'package:maps_app/util/apis.dart';

class PlaceWebService {
  late Dio dio;
  PlaceWebService() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> fetchPlacesSuggestions(
    String place,
    String sessionToken,
  ) async {
    Response response =
        await dio.get(placeSuggestionsBaseUrl, queryParameters: {
      'key': mapsAPI,
      'input': place,
      'type': 'address',
      'components': 'country:eg',
      'sessiontoken': sessionToken,
    });
    return response.data['predictions'];
  }

  Future<dynamic> fetchPlaceLocation(
    String placeId,
    String sessionToken,
  ) async {
    Response response = await dio.get(placeLocationBaseUrl, queryParameters: {
      'place_id': placeId,
      'fields': 'geometry',
      'key': mapsAPI,
      'sessiontoken': sessionToken,
    });
    print('weeeeeeeeeeeeeeeeeeeeeeeeeeeeb SERVICE ');
    // print(response.data['result']['geometry']['location']);
    // print(response.statusCode);
    return response.data['result']['geometry']['location'];
  }
}
