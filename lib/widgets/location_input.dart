import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      _isGettingLocation = false;

      log(locationData.latitude.toString());
      log(locationData.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'no location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );

    if (_isGettingLocation == true) {
      previewContent = const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          )),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('set current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('select on map'),
            ),
          ],
        )
      ],
    );
  }
}
