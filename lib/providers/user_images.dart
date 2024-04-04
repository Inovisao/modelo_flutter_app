import 'dart:io';
import 'package:app_skeleton/models/image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// Opens the SQlite local database for saving images
Future<Database> _getDatabase() async {
  // for debug purposes, dropping the table
  // bool dropTable = true;

  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'images.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_images(id TEXT PRIMARY KEY, user_id TEXT, creation_date TEXT NOT NULL, image_url TEXT NOT NULL, uploaded INTEGER DEFAULT 0);',
      );
    },
    version: 1,
  );

  // for debug purposes, dropping the table
  // if(dropTable){
  //   await db.delete('user_images');
  // }

  return db;
}

// Notifier class for the image db
class UserImagesNotifier extends StateNotifier<List<Photo>> {
  UserImagesNotifier() : super(const []);

  // loads all images currently saved in the database
  Future<void> loadPhotos() async {
    final db = await _getDatabase();
    final data = await db.query('user_images');
    final images = data
        .map(
          (row) => Photo(
            id: row['id'] as String,
            userId: row['user_id'] as String,
            creationDate: row['creation_date'] as String,
            image: File(row['image_url'] as String),
            isUploaded: row['uploaded'] as int,
          ),
        )
        .toList();

    state = images;
  }

  // Add new image to database
  void addPhoto(
      String creationDate, File imageTemp, String userId) async {
    // Obtains permanent db path for the photo
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageTemp.path);
    final copiedImage =
        await imageTemp.copy('${appDir.path}/$filename');

    // save photo with creator, date of creation and file info
    final newImageEntry = Photo(
        creationDate: creationDate,
        image: copiedImage,
        userId: userId);

    final db = await _getDatabase();
    db.insert('user_images', {
      'id': newImageEntry.id,
      'user_id': newImageEntry.userId,
      'creation_date': newImageEntry.creationDate,
      'image_url': newImageEntry.image.path,
      'uploaded': newImageEntry.isUploaded,
    });

    state = [newImageEntry, ...state];
  }

  // Removes a photo given its id
  void removePhotos(String id, File image) async {
    final db = await _getDatabase();

    await image.delete();

    db.delete('user_images', where: "id = ?", whereArgs: [id]);

    state = [];
  }
}

final userImagesProvider =
    StateNotifierProvider<UserImagesNotifier, List<Photo>>(
  (ref) => UserImagesNotifier(),
);
