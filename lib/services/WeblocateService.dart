import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:place_locator/models/places.dart';
import 'package:place_locator/utils/constants.dart';

class WebLocateService{

 Future<List<Places>> fetchPlacesByKeywordAndPosition(String keyword, double latitude, double longitude)async{
   http.Response response = await http.get(Uri.parse(Constants.locatePlacesByKeywordUrl(keyword, latitude, longitude)));
   if (response.statusCode == 200){
     final results = jsonDecode(response.body);
     Iterable list = results['results'];
     return list.map((place) => Places.fromJson(place)).toList();
   }else{
     throw Exception('can\'t get places');
   }
 }

}


