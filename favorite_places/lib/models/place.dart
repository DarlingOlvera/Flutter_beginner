import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    required this.description,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String description;
  final File image;
}
