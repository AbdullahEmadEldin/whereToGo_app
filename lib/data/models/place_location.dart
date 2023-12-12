// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceLocation {
  late double lat;
  late double lng;
  PlaceLocation({
    required this.lat,
    required this.lng,
  });

  PlaceLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
