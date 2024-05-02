import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/screens/choose_image.dart';
import 'package:app_skeleton/widgets/photo_couple_list.dart';
import 'package:app_skeleton/widgets/request_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadsScreen extends ConsumerStatefulWidget {
  const UploadsScreen({super.key});

  @override
  ConsumerState<UploadsScreen> createState() {
    return _UploadsScreenState();
  }
}

class _UploadsScreenState extends ConsumerState<UploadsScreen> {
  late Future<void> _photosFuture;
  bool _uploading = false;

  @override
  // Listen to provider to check for existing photos, and load them in order of upload
  void initState() {
    super.initState();
    _photosFuture = ref.read(userImagesProvider.notifier).loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final photoNotifier = ref.watch(userImagesProvider.notifier);
    final userPhotos = ref.watch(userImagesProvider);
    String counter = '${userPhotos.length} items in queue';

    Container uploadMessageContainer(String text) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(text)],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(counter),
        actions: [
          // Button to add new images
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ImagePickerScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () async {
              setState(
                () {
                  _uploading = true;
                },
              );
              try {
                await uploadObjectList(userPhotos, photoNotifier);
                setState(() {
                  _uploading = false;
                });
                // Check mounted context after async gap
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload Successful')));
                }
              } catch (error) {
                setState(() {
                  _uploading = false;
                });
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed. Error: ${error.toString()}')));
                }
              }
            },
          ),
        ],
      ),

      // Loading indicator
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _uploading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: _photosFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PhotoList(
                            photo: userPhotos,
                          ),
              ),
      ),
      bottomSheet:
          _uploading ? uploadMessageContainer('Upload in progress') : null,
    );
  }
}
