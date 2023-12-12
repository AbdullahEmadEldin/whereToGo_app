import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/business%20logic/maps_cubit/cubit/maps_cubit.dart';
import 'package:maps_app/data/repository/map_repo.dart';
import 'package:maps_app/data/web/place_webservice.dart';
import 'package:maps_app/presentation/widgets/floating_search_bar.dart';
import 'package:maps_app/presentation/widgets/side_menu.dart';
import 'package:maps_app/util/helpers.dart';
import 'package:maps_app/util/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///Declaring google maps variables
  static Position? position;
  StreamSubscription<Position>? _positionSubscription;

  Completer<GoogleMapController> mapController = Completer();
  static final CameraPosition _currentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 17);

  @override
  void initState() {
    super.initState();
    _getCurruentLocation();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : const Center(child: CircularProgressIndicator()),
            BlocProvider(
              create: (context) =>
                  MapsCubit(MapRepository(placeWebService: PlaceWebService())),
              child: FloatingSearch(
                mapController: mapController,
                position: position,
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 15, 30),
          child: FloatingActionButton(
            onPressed: () {
              _showCurrentLocation();
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.place),
          ),
        ),
      ),
    );
  }

  ///==========================================
  ///Implementing basic google maps methods
  ///==========================================
  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _currentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      markers: locator.get<Set<Marker>>(),
      onMapCreated: (controller) {
        mapController.complete(controller);
      },
    );
  }

  Future<void> _getCurruentLocation() async {
    await Helpers.detectCurrentLocation();
    //? StreamSubScription and mounted propterty to avoid setState calling of it's widget after it disposed from the tree
    _positionSubscription = Geolocator.getPositionStream().listen((position) {
      if (mounted) {
        _HomePageState.position = position;
        setState(() {});
      }
    });
  }

  Future<void> _showCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_currentLocationCameraPosition));
  }
}
