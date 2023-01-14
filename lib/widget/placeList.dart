import 'package:flutter/material.dart';
import 'package:place_locator/viewmodel/placeViewModel.dart';
import 'package:place_locator/utils/constants.dart';

class PlaceList extends StatelessWidget {

  final List<PlaceViewModel> places;
  Function(PlaceViewModel) onSelected;
  PlaceList({required this.places, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
        itemBuilder: (context, index){

        final place = places[index];

        return ListTile(
          onTap: (){
            onSelected(place);
          },
          leading: Container(
            width: 100,
            height: 100,
            child: place.photoUrl.isEmpty? Image.asset('images/locate.png') : Image.network(Constants.referenceImageUrl(place.photoUrl), fit: BoxFit.cover,),
          ),
          title: Text(place.name),
        );
        }
    );
  }
}
