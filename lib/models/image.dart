import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PhotoCouple {
  PhotoCouple({
    required this.creationDate,
    required this.imagePano,
    required this.imageForm,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String creationDate;
  final File imagePano;
  final File imageForm;
}
