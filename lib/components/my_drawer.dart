import 'package:flutter/material.dart';
import 'package:notes/components/my_drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
            child: Container(
              height: 150,
              child: Image.asset(
                'images/note.png',
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          SizedBox(height: 24),
          MyDrawerTile(
            title: 'Notes',
            leading: Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          MyDrawerTile(
            title: 'Settings',
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
