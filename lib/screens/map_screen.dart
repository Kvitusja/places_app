import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool? isSelecting;
  const MapScreen({
    Key? key,
    this.initialLocation =
        const PlaceLocation(latitude: 48.34731, longitude: 33.50034),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A map'),
        actions: [
          if (widget.isSelecting!)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(
                        _pickedLocation,
                      );
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(widget.initialLocation!.latitude,
              widget.initialLocation!.longitude),
        ),
        onTap: widget.isSelecting! ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting!)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('marker1'),
                  position: _pickedLocation ??
                      LatLng(widget.initialLocation!.latitude,
                          widget.initialLocation!.longitude),
                ),
              },
      ),
    );
  }
}
