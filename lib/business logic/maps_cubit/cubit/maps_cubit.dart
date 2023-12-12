import 'package:bloc/bloc.dart';
import 'package:maps_app/data/models/place_location.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/data/repository/map_repo.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapRepository mapRepository;
  MapsCubit(this.mapRepository) : super(MapsInitial());

  void viewPlacesSuggestion(
      {required String place, required String sessionToken}) {
    try {
      mapRepository
          .getPlacesSuggestions(place: place, sessionToken: sessionToken)
          .then(
            (places) => emit(SuggestionLoadedSucessfuly(places: places)),
          );
    } catch (error) {
      emit(SuggestionsLoadingFailure(errorMsg: error.toString()));
    }
  }

  void viewPlaceLocation(
      {required String placeId, required String sessionToken}) {
    emit(PlaceLoading());
    try {
      mapRepository
          .getPlaceLocation(placeId: placeId, sessionToken: sessionToken)
          .then((location) =>
              emit(PlaceLocationLoadedSucessfuly(placeLocation: location)));
    } catch (error) {
      emit(PlaceLocationLoadingFailure(errorMsg: error.toString()));
    }
  }
}
