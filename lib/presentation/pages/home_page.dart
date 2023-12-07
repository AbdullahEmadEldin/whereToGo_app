import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/presentation/widgets/side_menu.dart';
import 'package:maps_app/util/helpers.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

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
  FloatingSearchBarController searchBarController =
      FloatingSearchBarController();

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
        drawer: SideMenu(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : const Center(child: CircularProgressIndicator()),
            _buildFloatingSearchBar(),
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

  Widget _buildFloatingSearchBar() {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
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
      onQueryChanged: (query) {},
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
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        );
      },
    );
  }

  ///==========================================
  ///Implementing google maps methods
  ///==========================================
  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _currentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        mapController.complete(controller);
      },
    );
  }

  Future<void> _getCurruentLocation() async {
    await Helpers.detectCurrentLocation();
    //! StreamSubScription and mounted propterty to avoid setState calling of it's widget after it disposed from the tree
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
