import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;

  Place({
    String? id,
    required this.title,
    required this.image,
  }) : id = id?? uuid.v4();
}
