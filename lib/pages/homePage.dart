import 'dart:async';
import 'package:place_locator/services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:place_locator/viewmodel/placeViewModel.dart';
import 'package:place_locator/widget/placeList.dart';
import 'package:map_launcher/map_launcher.dart' as launch;

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

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    return places.map((place) {
      return Marker(
          markerId: MarkerId(place.placeId),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: place.name),
          position: LatLng(place.latitude, place.longitude));
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

  Future<void> _launchMap(PlaceViewModel vm)async{
    final availableMaps = await launch.MapLauncher.installedMaps;
    await availableMaps.first.showMarker(coords: launch.Coords(vm.latitude, vm.longitude), title: vm.name);
    if(await launch.MapLauncher.isMapAvailable(launch.MapType.google) ?? false){
      await launch.MapLauncher.showMarker(mapType: launch.MapType.google, coords: launch.Coords(vm.latitude, vm.longitude), title: vm.name);
    }else if(await launch.MapLauncher.isMapAvailable(launch.MapType.apple) ?? false){
      await launch.MapLauncher.showMarker(mapType: launch.MapType.apple, coords: launch.Coords(vm.latitude, vm.longitude), title: vm.name);
    }
    print(launch.MapLauncher.isMapAvailable(launch.MapType.google));
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: vm.mapType,
            markers: _getPlaceMarkers(vm.areas),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(6.5243793, 3.3792057), zoom: 14),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Search here',
                    fillColor: Colors.white,
                    filled: true),
                onSubmitted: (place) {
                  vm.displayPlaces(
                      place, location.latitude!, location.longitude!);
                },
              ),
            ),
          ),
          Visibility(
            visible: vm.areas.isNotEmpty ? true : false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => PlaceList(places: vm.areas, onSelected: _launchMap,));
                    },
                    child: const Text(
                      'Show List',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 10,
            child: FloatingActionButton(
              onPressed: (){
                vm.toogleMapType();
                print('pressed');
              },
              child: Icon(Icons.map),
            ),
          )
        ],
      ),
    );
  }
}
