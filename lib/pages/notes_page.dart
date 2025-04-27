import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/pages/details_note.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // CREATE
  void createNote() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) =>
                const DetailsNotePage(note: null, isExistingNote: false),
      ),
    );
  }

  // READ
  void readNotes() {
    context.read<NoteDatabase>().readNotes();
  }

  // UPDATE
  void updateNote(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsNotePage(note: note, isExistingNote: true),
      ),
    );
  }

  // DELETE
  @override
  Widget build(BuildContext context) {
    final noteDataBase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDataBase.currentNotes;
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content.characters.take(50).toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => updateNote(note),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => noteDataBase.deleteNote(note.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
