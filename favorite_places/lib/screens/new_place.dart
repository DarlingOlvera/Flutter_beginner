import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'dart:io';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  var _enteredDescription = '';
  File? _selectedImage;

  void _savePlace() {
    if (_formKey.currentState!.validate() || _selectedImage == null) {
      _formKey.currentState!.save();

      ref
          .read(userPlacesProvider.notifier)
          .addPlace(_enteredTitle, _enteredDescription, _selectedImage!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Place',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 12,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Title'),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters long';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Description'),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                maxLines: 3,
                onSaved: (value) {
                  _enteredDescription = value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //Image input
              ImageInput(
                onSelectedImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //LocationInput(),
              /*  const SizedBox(
                height: 12,
              ), */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _savePlace,
                    child: const Text('Add place'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
