import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:place_locator/utils/constants.dart';

class WebLocateService{

 void fetchPlacesByKeywordAndPosition(String keyword, double latitude, double longitude)async{
   http.Response response = await http.get(Uri.parse(Constants.locatePlacesByKeywordUrl(keyword, latitude, longitude)));
   if (response.statusCode == 200){
     final results = jsonDecode(response.body);
     Iterable list = results['results'];
   }
 }

}


