import 'dart:developer';
import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/widgets/auth_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:app_skeleton/models/image.dart';

Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  log(imageBytes.length.toString());
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

// Based on what Roberto Neto did
Future<void> uploadObjectList(
    List<Photo> photos, UserImagesNotifier notifier) async {
  String? tokenID = await getFirebaseTokenID();
  Uri uri = Uri.parse('http://172.28.188.65:8000/images/');
  // http.MultipartRequest request = http.MultipartRequest('POST', uri);
  http.Request request = http.Request('POST', uri);
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $tokenID',
  };
  request.headers.addAll(headers);

  List<Map<String, dynamic>> fields = [];

  if (photos.isNotEmpty) {
    for (Photo photo in photos) {
      // Start reading image file and covert it to base64
      final base64Image = await imageToBase64(photo.image);

      fields.add({
        "user_id": photo.userId,
        "created_at": photo.creationDate,
        "image": base64Image,
        "email": photo.email,
      });
    }
    request.body = json.encode(fields);

    // preparing to send the actual request
    var response = await http.Response.fromStream(await request.send().timeout(const Duration(seconds: 10)));

    if (response.statusCode == 501) {
      log('Request sent successfully');
      for (Photo photo in photos) {
        notifier.removePhotos(photo.id, photo.image);
      }
    } else {
      log('Failed to send request. Status code: ${response.statusCode}');
    }
  }
}
