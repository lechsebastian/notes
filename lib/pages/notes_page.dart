import 'package:flutter/material.dart';
import 'package:notes/pages/new_note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // CREATE
  void createNote() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewNotePage()));
  }

  // READ
  void readNotes() {}

  // UPDATE

  // DELETE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
