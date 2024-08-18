import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectPlace});

  final void Function(PlaceLocation location) onSelectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final long = _pickedLocation!.longitude;

    return 'https://image.maps.hereapi.com/mia/v3/base/mc/center:$lat,$long;zoom=16/600x300/png?apiKey=1HL2xxdgmjJkRg-txNPrD8ju88AavGZa0TKzHqQw1kM&overlay=point:$lat,$long;label=You are here;size=large;text-color=#FF000080';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
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
    final long = locationData.longitude;
    final lat = locationData.latitude;

    if (lat == null || long == null) {
      return;
    }

    final url = Uri.parse(
        'https://revgeocode.search.hereapi.com/v1/revgeocode?at=$lat,$long&apikey=1HL2xxdgmjJkRg-txNPrD8ju88AavGZa0TKzHqQw1kM');
    final response = await http.get(url);

    final data = json.decode(response.body);
    final address = data['items'][0]['address']['label'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: long, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectPlace(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text('No location chosen',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ));

    if (_pickedLocation != null) {
      previewContent = Image.network(locationImage,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
