import 'dart:developer';
import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/widgets/auth_handler.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:app_skeleton/models/image.dart';

Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

Future<dynamic> createFutureRequest(
  Uri uri,
  Map<String, String> headers,
  Photo photo,
  UserImagesNotifier notifier,
) async {
  final base64Image = await imageToBase64(photo.image);

  // Prepare request body
  var requestBody = json.encode({
    "user_id": photo.userId,
    "created_at": photo.creationDate,
    "image": base64Image,
    "email": photo.email,
  });

  // Create and send the request
  var response = await http.post(
    uri,
    headers: headers,
    body: requestBody,
  );

  // Handle response
  if (response.statusCode == 201) {
    log('Request sent successfully');
    notifier.removePhotos(photo.id, photo.image);
  } else {
    log('Failed to save images. Status code: ${response.statusCode}');
  }
}

// Based on what Roberto Neto did
Future<void> uploadObjectList(List<Photo> photos, UserImagesNotifier notifier) async {
  String? tokenID = await getFirebaseTokenID();
  Uri uri = Uri.parse('http://172.28.188.65:8000/images/');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $tokenID',
  };

  var futureGroup = FutureGroup();

  if (photos.isNotEmpty) {
    for (Photo photo in photos) {
      futureGroup.add(createFutureRequest(uri, headers, photo, notifier));
    }

    // Wait for all requests to complete
    futureGroup.close();

  }
}