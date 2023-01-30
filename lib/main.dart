import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/great_places.dart';
import 'screens/place_details_screen.dart';
import 'screens/places_list_screen.dart';
import 'screens/add_place_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GreatPlaces(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}