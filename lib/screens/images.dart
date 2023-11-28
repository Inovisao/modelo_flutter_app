import 'package:app_skeleton/screens/auth.dart';
import 'package:app_skeleton/screens/choose_image.dart';
import 'package:app_skeleton/screens/uploads.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() {
    return _ImageScreenState();
  }
}

class _ImageScreenState extends State<ImageScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget activePage = const ImagePickerScreen();
    var activePageTitle = 'Take a picture';

    if (_selectedPageIndex == 1) {
      activePage = const UploadsScreen();
      activePageTitle = 'Uploads';
    }

    void _onLogoutTap() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
      ),
    );
  }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _onLogoutTap,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedPageIndex,
        onDestinationSelected: (int index) {
          //TODO: MaterialPageRoute to Uploads and Photos Screen
          setState(() {
            _selectedPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.photo),
            label: 'Photos',
          ),
          NavigationDestination(
            icon: Icon(Icons.upload_file),
            label: 'Uploads',
          ),
        ],
      ),
      body: activePage,
    );
  }
}
