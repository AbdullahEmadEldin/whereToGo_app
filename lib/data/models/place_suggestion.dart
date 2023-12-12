class PlaceSuggestion {
  late String description;
  late String placeId;

  PlaceSuggestion({required this.description, required this.placeId});
  PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
  }
}
