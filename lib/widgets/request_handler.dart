import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:app_skeleton/models/image.dart';

// Based on what Roberto Neto did
Future<void> uploadObjectList(List<Photo> photos) async {
  Uri uri = Uri.parse('http://172.28.188.65:8000/images/');
  http.MultipartRequest request = http.MultipartRequest('POST', uri);
  var headers = {
    'Content-Type': 'multipart/form-data',
  };
  request.headers.addAll(headers);

  List<Map<String, dynamic>> fields = [];

  if (photos.isNotEmpty) {
    for (Photo photo in photos) {
      // Start reading the image file to insert into request
      var stream = http.ByteStream(photo.image.openRead());
      var length = await photo.image.length();
      var multipartFile = http.MultipartFile('image', stream, length);

      // files.add(file);
      fields.add({
        'user_id': photo.userId,
        'created_at': photo.creationDate,
      });

      request.files.add(multipartFile);      
    }

    request.fields['fields'] = fields.toString();

    // preparing to send the actual request
    var response = await http.Response.fromStream(await request.send().timeout(const Duration(seconds: 20)));

    if (response.statusCode == 201){
      log('Request sent successfully');
    } else {
      log('Failed to send request. Status code: ${response.statusCode}');
    }
  }
}
