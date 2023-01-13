import 'package:flutter/material.dart';
import 'package:place_locator/viewmodel/placeListViewModel.dart';
import 'pages/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (BuildContext context) => PlaceListViewModel(),
        child: HomePage(),
      ),
    );
  }
}

