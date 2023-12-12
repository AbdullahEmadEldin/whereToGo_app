part of 'maps_cubit.dart';

@immutable
sealed class MapsState {}

final class MapsInitial extends MapsState {}

///Place suggestions states
final class SuggestionLoadedSucessfuly extends MapsState {
  final List<PlaceSuggestion> places;

  SuggestionLoadedSucessfuly({required this.places});
}

final class SuggestionsLoadingFailure extends MapsState {
  final String errorMsg;

  SuggestionsLoadingFailure({required this.errorMsg});
}

/// Place location details states
final class PlaceLoading extends MapsState {}

final class PlaceLocationLoadedSucessfuly extends MapsState {
  final PlaceLocation placeLocation;

  PlaceLocationLoadedSucessfuly({required this.placeLocation});
}

final class PlaceLocationLoadingFailure extends MapsState {
  final String errorMsg;

  PlaceLocationLoadingFailure({required this.errorMsg});
}
