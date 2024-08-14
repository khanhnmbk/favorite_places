import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;

  Place({required this.title}) : id = uuid.v4();
}

class PlaceModelListNotifier extends StateNotifier<List<Place>> {
  PlaceModelListNotifier() : super([]);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<PlaceModelListNotifier, List<Place>>((ref) {
  return PlaceModelListNotifier();
});
