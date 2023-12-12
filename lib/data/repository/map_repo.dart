import 'package:maps_app/data/models/place_location.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/data/web/place_webservice.dart';

class MapRepository {
  final PlaceWebService placeWebService;

  MapRepository({required this.placeWebService});
  Future<List<PlaceSuggestion>> getPlacesSuggestions(
      {required String place, required String sessionToken}) async {
    final suggestions =
        await placeWebService.fetchPlacesSuggestions(place, sessionToken);
    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<PlaceLocation> getPlaceLocation(
      {required String placeId, required String sessionToken}) async {
    final location =
        await placeWebService.fetchPlaceLocation(placeId, sessionToken);
    return PlaceLocation.fromJson(location);
  }
}
