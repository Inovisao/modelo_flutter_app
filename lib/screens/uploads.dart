import 'package:app_skeleton/providers/user_images.dart';
import 'package:app_skeleton/screens/choose_image.dart';
import 'package:app_skeleton/widgets/photo_couple_list.dart';
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

  @override
  void initState() {
    super.initState();
    _photosFuture = ref.read(userImagesProvider.notifier).loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final userPhotoCouples = ref.watch(userImagesProvider);
    String counter = '${userPhotoCouples.length} items in queue';

    return Scaffold(
      appBar: AppBar(
        title: Text(counter),
        actions: [
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
            onPressed: () {
              setState(
                () {
                  counter = '${userPhotoCouples.length} items in queue';
                },
              );
            },
          ),
        ], //TODO: force upload
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _photosFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PhotoCoupleList(
                      photoCouples: userPhotoCouples,
                    ),
        ),
      ),
    );
  }
}
