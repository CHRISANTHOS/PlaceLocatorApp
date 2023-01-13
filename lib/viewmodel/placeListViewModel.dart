import 'package:flutter/cupertino.dart';
import 'package:place_locator/models/places.dart';
import 'package:place_locator/services/WeblocateService.dart';

import 'placeViewModel.dart';

class PlaceListViewModel extends ChangeNotifier{

  List<PlaceViewModel> areas = <PlaceViewModel>[];

  Future<void> displayPlaces(String keyword, double latitude, double longitude)async{
    List<Places> places = await WebLocateService().fetchPlacesByKeywordAndPosition(keyword, latitude, longitude);
    areas =  places.map((area) => PlaceViewModel(area: area)).toList();
    print('done');
    notifyListeners();
  }


}