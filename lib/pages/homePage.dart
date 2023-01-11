import 'dart:async';
import 'package:place_locator/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(location.latitude);
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await location.getCurrentLocation();
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(location.latitude!, location.longitude!), zoom: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(6.5243793, 3.3792057), zoom: 14),
          )
        ],
      ),
    );
  }
}
