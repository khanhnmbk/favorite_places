import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String title = '';

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Add a New Place'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
                onPressed: () {
                  formKey.currentState!.save();
                  ref.read(favoritePlacesProvider.notifier).addPlace(
                        Place(title: title),
                      );

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
