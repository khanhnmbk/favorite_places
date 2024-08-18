import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

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
                    builder: (context) => const AddPlaceScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlaceList(places: userPlaces),
        ));
  }
}
