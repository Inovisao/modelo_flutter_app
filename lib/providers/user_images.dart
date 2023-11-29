import 'dart:io';
import 'package:app_skeleton/models/image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'images.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_images(id TEXT PRIMARY KEY, name TEXT, imageForm TEXT,  imagePano TEXT,)');
    },
    version: 1,
  );
  return db;
}

class UserImagesNotifier extends StateNotifier<List<ImageCoupleItem>> {
  UserImagesNotifier() : super(const []);

  Future<void> loadImages() async {
    final db = await _getDatabase();
    final data = await db.query('user_images');
    final images = data
        .map(
          (row) => ImageCoupleItem(
            id: row['id'] as String,
            name: row['title'] as String,
            imageForm: File(row['image_form'] as String),
            imagePano: File(row['image_pano'] as String),
          ),
        )
        .toList();

    state = images;
  }

  void addImages(String name, File imageForm, File imagePano) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filenameForm = path.basename(imageForm.path);
    final filenamePano = path.basename(imagePano.path);
    final copiedImageForm =
        await imageForm.copy('${appDir.path}/$filenameForm');
    final copiedImagePano =
        await imagePano.copy('${appDir.path}/$filenamePano');

    final newImageEntry =
        ImageCoupleItem(name: name, imagePano: imagePano, imageForm: imageForm);

    final db = await _getDatabase();
    db.insert('user_images', {
      'id': newImageEntry.id,
      'title': newImageEntry.name,
      'image_form': newImageEntry.imageForm.path,
      'image_pano': newImageEntry.imagePano.path,
    });

    state = [newImageEntry, ...state];
  }
}

final userImagesProvider =
    StateNotifierProvider<UserImagesNotifier, List<ImageCoupleItem>>(
  (ref) => UserImagesNotifier(),
);
