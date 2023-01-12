
class Constants {

  static String locatePlacesByKeywordUrl(String keyword, double latitude, double longitude){
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$latitude%2C$longitude&radius=1500&type=restaurant&key=AIzaSyDnJUP6M7hHqvK2YWZJOYeVHfV_mEOu62s';
  }

}