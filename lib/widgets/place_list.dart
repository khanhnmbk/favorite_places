import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceList extends ConsumerWidget {
  const PlaceList({super.key, required this.places});
  final List<Place> places;

  void _onTapPlace(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceDetail(place),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (places.isEmpty) {
      return Center(
        child: Text('No places yet',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
      );
    }

    return Center(
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(places[index].image),
              ),
              onTap: () => _onTapPlace(context, places[index]),
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(places[index].location.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)));
        },
      ),
    );
  }
}
