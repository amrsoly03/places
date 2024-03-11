import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(children: [
        Image.file(
          place.image,
          height: 400,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ]),
    );
  }
}
