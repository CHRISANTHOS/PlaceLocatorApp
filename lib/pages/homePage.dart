import 'dart:async';
import 'package:place_locator/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:place_locator/viewmodel/placeViewModel.dart';
import 'package:geolocator/geolocator.dart';

import '../viewmodel/placeListViewModel.dart';

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

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places){
    return places.map((place) {
      return Marker(
          markerId: MarkerId(place.placeId),
        icon:  BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: place.name),
        position: LatLng(place.latitude, place.longitude)
      );
    }).toSet();
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
    final vm = Provider.of<PlaceListViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: _getPlaceMarkers(vm.areas),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(6.5243793, 3.3792057), zoom: 14),
          ),
          SafeArea(
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Search here',
                  fillColor: Colors.white,
                  filled: true),
              onSubmitted: (place){
                vm.displayPlaces(place, location.latitude!, location.longitude!);
              },
            ),
          )
        ],
      ),
    );
  }
}
