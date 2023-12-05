import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/business%20logic/phone_auth/cubit/phone_auth_cubit.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/util/helpers.dart';
import 'package:maps_app/util/locator.dart';
import 'package:maps_app/util/navigation/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///Declaring google maps variables
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).WhereToGO,
        ),
      ),
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(child: CircularProgressIndicator())
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 15, 30),
        child: ElevatedButton(
            onPressed: () {
              _showCurrentLocation();
            },
            child: const Icon(Icons.place)),
      ),
    );
  }

  ///==========================================
  ///Implementing google maps methods
  ///==========================================
  Future<void> _getCurruentLocation() async {
    await Helpers.detectCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _showCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_currentLocationCameraPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _currentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        _mapController.complete(controller);
      },
    );
  }
}

///**********************LOG OUt
///  BlocProvider<PhoneAuthCubit>(
//   create: (context) => PhoneAuthCubit(),
//   child: Center(
//     child: ElevatedButton(
//       onPressed: () {
//         locator.get<PhoneAuthCubit>().logOut();
//         context.goNamed(AppRoutes.phoneEnterScreen);
//       },
//       style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
//           minimumSize: const MaterialStatePropertyAll(Size(110, 50))),
//       child: Text(
//         S.of(context).LogOut,
//       ),
//     ),
//   ),
// ),
/// */
