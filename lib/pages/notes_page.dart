import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/my_drawer.dart';
import 'package:notes/components/my_note_tile.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => readNotes());
  }

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
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return MyNoteTile(
                  note: note,
                  onUpdatePress: () => updateNote(note),
                  onDeletePress: () => noteDataBase.deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
