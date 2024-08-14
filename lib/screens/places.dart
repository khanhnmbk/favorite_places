import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/new_place.dart';
import 'package:favorite_places/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoritePlacesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Favorite Places'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Add a new place
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NewPlace(),
                  ),
                );
              },
            ),
          ],
        ),
        body: const PlaceList(places: []));
  }
}
