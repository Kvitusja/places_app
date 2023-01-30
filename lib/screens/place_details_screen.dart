import 'package:flutter/material.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectPlace = Provider.of<GreatPlaces>(context, listen: false)
        .findbyId(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectPlace.location!.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => MapScreen(
                      initialLocation: selectPlace.location, isSelecting: false,
                    ),
                  ),
                );
              },
              child: const Text('View on Map'))
        ],
      ),
    );
  }
}
