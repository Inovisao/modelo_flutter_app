import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ImageCoupleItem {
  ImageCoupleItem({
    required this.name,
    required this.imagePano,
    required this.imageForm,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final File imagePano;
  final File imageForm;
}
