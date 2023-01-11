import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(4.903663, 7.009452),
              zoom: 14
            ),
          )
        ],
      ),
    );
  }
}
