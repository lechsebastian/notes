import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/pages/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
    );
  }
}
