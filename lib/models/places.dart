import 'package:flutter/material.dart';

class Places {
  final String placeId;
  final double latitude;
  final double longitude;
  final String name;
  final String photoUrl;

  Places(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.placeId,
      required this.photoUrl});

  factory Places.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    final photos = json['photos'];
    return Places(
        name: json['name'] ?? '',
        latitude: location['lat'],
        longitude: location['lng'],
        placeId: json['place_id'] ?? '',
        photoUrl: photos == null ? 'images/locate.png' : photos.first['photo_reference'].toString());
  }
}
