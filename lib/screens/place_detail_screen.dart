import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetail extends StatelessWidget {
  const PlaceDetail(this.place, {super.key});
  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final long = place.location.longitude;

    return 'https://image.maps.hereapi.com/mia/v3/base/mc/center:$lat,$long;zoom=16/600x300/png?apiKey=1HL2xxdgmjJkRg-txNPrD8ju88AavGZa0TKzHqQw1kM&overlay=point:$lat,$long;label=You are here;size=large;text-color=#FF000080';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(place.title),
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(children: [
                CircleAvatar(
                    radius: 70, backgroundImage: NetworkImage(locationImage)),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(place.location.address,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface))),
              ])),
        ],
      ),
    );
  }
}
