import 'dart:io';
import 'package:app_skeleton/models/image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  // bool dropTable = false;

  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'images.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_images(id TEXT PRIMARY KEY, creation_date TEXT NOT NULL, image_Form_Url TEXT NOT NULL, image_Pano_Url TEXT NOT NULL, uploaded INTEGER DEFAULT 0);',
      );
    },
    version: 1,
  );

  // if(dropTable){
  //   await db.delete('user_images');
  // }

  return db;
}

class UserImagesNotifier extends StateNotifier<List<PhotoCouple>> {
  UserImagesNotifier() : super(const []);

  Future<void> loadPhotos() async {
    final db = await _getDatabase();
    final data = await db.query('user_images');
    final images = data
        .map(
          (row) => PhotoCouple(
            id: row['id'] as String,
            creationDate: row['creation_date'] as String,
            imageForm: File(row['image_Form_Url'] as String),
            imagePano: File(row['image_Pano_Url'] as String),
            isUploaded: row['uploaded'] as int,
          ),
        )
        .toList();

    state = images;
  }

  void addPhotos(String creationDate, File imageFormTemp, File imagePanoTemp) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filenameForm = path.basename(imageFormTemp.path);
    final filenamePano = path.basename(imagePanoTemp.path);
    final copiedImageForm =
        await imageFormTemp.copy('${appDir.path}/$filenameForm');
    final copiedImagePano =
        await imagePanoTemp.copy('${appDir.path}/$filenamePano');

    final newImageEntry = PhotoCouple(
        creationDate: creationDate, imagePano: copiedImagePano, imageForm: copiedImageForm);

    final db = await _getDatabase();
    db.insert('user_images', {
      'id': newImageEntry.id,
      'creation_date': newImageEntry.creationDate,
      'image_Form_Url': newImageEntry.imageForm.path,
      'image_Pano_Url': newImageEntry.imagePano.path,
      'uploaded': newImageEntry.isUploaded,
    });

    state = [newImageEntry, ...state];
  }
}

final userImagesProvider =
    StateNotifierProvider<UserImagesNotifier, List<PhotoCouple>>(
  (ref) => UserImagesNotifier(),
);
