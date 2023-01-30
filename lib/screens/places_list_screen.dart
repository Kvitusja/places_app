import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/great_places.dart';
import 'place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Got no places yet'),
                    ),
                    builder: (context, greatPlaces, child) => greatPlaces
                            .items.isEmpty
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                subtitle: Text(
                                    greatPlaces.items[index].location!.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailsScreen.routeName,
                                      arguments: greatPlaces.items[index].id);
                                },
                              );
                            },
                          ),
                  ),
      ),
    );
  }
}
