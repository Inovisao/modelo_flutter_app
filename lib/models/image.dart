import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Photo {
  Photo(
      {required this.creationDate,
      required this.image,
      required this.userId,
      String? id,
      int? isUploaded})
      : id = id ?? uuid.v4(),
        isUploaded = isUploaded ?? 0;

  final String id;
  final String userId;
  final String creationDate;
  final File image;
  final int isUploaded;
}
