import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Photo {
  Photo({
    required this.creationDate,
    required this.image,
    required this.userId,
    required this.email,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String userId;
  final String creationDate;
  final File image;
  final String email;
}
