import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _textController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enterTitle = _textController.text;

    if (enterTitle.isEmpty || _selectedImage == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enterTitle, _selectedImage!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _textController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 15),
            ImageInput(onSelectImage: (File image) => _selectedImage = image),
            const SizedBox(height: 15),
            const LocationInput(),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('add place'),
            )
          ],
        ),
      ),
    );
  }
}
