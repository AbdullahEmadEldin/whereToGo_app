import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/business%20logic/maps_cubit/cubit/maps_cubit.dart';
import 'package:maps_app/data/models/place_location.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/presentation/widgets/searched_place_item.dart';
import 'package:maps_app/util/locator.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:uuid/uuid.dart';

class FloatingSearch extends StatefulWidget {
  final Completer<GoogleMapController> mapController;
  final Position? position;
  const FloatingSearch(
      {super.key, required this.mapController, required this.position});

  @override
  State<FloatingSearch> createState() => _FloatingSearchState();
}

class _FloatingSearchState extends State<FloatingSearch> {
  FloatingSearchBarController searchBarController =
      FloatingSearchBarController();
  final sessionToken = const Uuid().v4();

  ///Declration of new searched place variables
  Set<Marker> locationsMarkers = Set();
  late PlaceSuggestion searchedLocationInfo;
  late Marker currentLocationMarker;
  late Marker searchedLocationMarker;
  late PlaceLocation selectedPlace;
  late CameraPosition goToSearchedLocationCameraPosition;

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      queryStyle: const TextStyle(color: Colors.black),
      controller: searchBarController,
      elevation: 8,
      hint: 'Choose a place...',
      border: const BorderSide(style: BorderStyle.none),
      margins: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      padding: const EdgeInsets.only(left: 8),
      scrollPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      transition: CircularFloatingSearchBarTransition(),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.bounceInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 600),
      onQueryChanged: (query) {
        BlocProvider.of<MapsCubit>(context)
            .viewPlacesSuggestion(place: query, sessionToken: sessionToken);
      },
      onFocusChanged: (isFocused) {},
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        )
      ],
      builder: (context, transition) {
        return Column(
          children: [
            _searchItemsBlocBuilder(),
            _buildBlocListnerForNewLocation(),
          ],
        );
      },
    );
  }

  BlocBuilder<MapsCubit, MapsState> _searchItemsBlocBuilder() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is SuggestionLoadedSucessfuly) {
          final places = state.places;
          if (places.isEmpty) {
            return const Center(
              child: Text('No Such place'),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: places.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                searchedLocationInfo = places[index];
                searchBarController.close();
                BlocProvider.of<MapsCubit>(context).viewPlaceLocation(
                    placeId: places[index].placeId, sessionToken: sessionToken);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SearchedPlaceItem(placeSuggestion: places[index]),
              ),
            ),
          );
        } else if (state is SuggestionsLoadingFailure) {
          return Center(
            child: Text('web service error: ${state.errorMsg.toString()}'),
          );
        } else {
          return Center(
            child: Text('Some staate: ${state.toString()}'),
          );
        }
      },
    );
  }

  Widget _buildBlocListnerForNewLocation() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoadedSucessfuly) {
          selectedPlace = state.placeLocation;
          goToSearchedLocation();
        } else if (state is PlaceLocationLoadingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: const SizedBox(),
    );
  }

  ///===========================================================
  ///Implementing (Searching for place  in google maps) methods
  ///===========================================================
  void initializeNewCameraPosition() {
    goToSearchedLocationCameraPosition = CameraPosition(
        bearing: 0.0,
        tilt: 0.0,
        zoom: 13,
        target: LatLng(selectedPlace.lat, selectedPlace.lng));
  }

  Future<void> goToSearchedLocation() async {
    initializeNewCameraPosition();
    final GoogleMapController newMapController =
        await widget.mapController.future;
    newMapController.animateCamera(
        CameraUpdate.newCameraPosition(goToSearchedLocationCameraPosition));
    markSearchedLocation();
  }

  ///===========================================================
  ///Implementing (Marking searched & current location) methods
  ///===========================================================
  void markSearchedLocation() {
    searchedLocationMarker = Marker(
      position: goToSearchedLocationCameraPosition.target,
      markerId: const MarkerId('1'), //mock Id
      infoWindow: InfoWindow(title: searchedLocationInfo.description),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () {
        markCurrentLocation();
      },
    );
    addMarkerToMarkersAndUpdateUI(searchedLocationMarker);
  }

  void markCurrentLocation() {
    currentLocationMarker = Marker(
      position: LatLng(widget.position!.latitude, widget.position!.longitude),
      markerId: const MarkerId('2'), //mock Id
      infoWindow: const InfoWindow(title: 'Your Current location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () {},
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      locationsMarkers.add(marker);
      locator.get<Set<Marker>>().add(marker);
    });
  }
}
