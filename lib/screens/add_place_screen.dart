import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final title = _titleController.text;

    if (title.isEmpty || _pickedImage == null || _selectedLocation == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(title, _pickedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  void _onSelectImage(File image) {
    _pickedImage = image;
  }

  void _onSelectLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 20),
              ImageInput(onSelectImage: _onSelectImage),
              const SizedBox(height: 20),
              LocationInput(onSelectPlace: _onSelectLocation),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
                onPressed: _savePlace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
