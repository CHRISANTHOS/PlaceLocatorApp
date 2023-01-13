
import 'package:place_locator/models/places.dart';

class PlaceViewModel{

  Places _places;

  PlaceViewModel({required Places area}): _places = area;

  String get name{
    return _places.name;
  }
  double get longitude{
    return _places.longitude;
  }
  double get latitude{
    return _places.latitude;
  }
  String get placeId{
    return _places.placeId;
  }
  String get photoUrl{
    return _places.photoUrl;
  }

}