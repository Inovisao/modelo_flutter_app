import 'package:app_skeleton/models/image.dart';
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

  //final _items = List<String>.generate(10, (index) => 'Item ${index + 1}');
  final _allCouples = [];

  void _addPhotos() async {
    final newPhotos = await Navigator.of(context).push<PhotoCouple>(
      MaterialPageRoute(
        builder: (ctx) => const ImagePickerScreen(),
      ),
    );

    if (newPhotos == null) {
      return;
    }

    setState(() {
      _allCouples.add(newPhotos);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPhotos = ref.watch(userImagesProvider);

    void _removePhotos(String item) {
      final index = _allCouples.indexOf(item);

      setState(() {
        _allCouples.remove(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('${_allCouples.length} items in queue'),
          IconButton(
            onPressed: _addPhotos,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.upload),
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
                      photoCouples: userPhotos,
                    ),
        ),
      ),
    );
  }
}
