import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // I N I T I A L I Z E
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];

  // C R E A T E
  Future<void> createNote(String titleFromuser, String contentFromuser) async {
    final newNote =
        Note()
          ..title = titleFromuser
          ..content = contentFromuser
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

    await isar.writeTxn(() => isar.notes.put(newNote));

    await readNotes();
  }

  // R E A D
  Future<void> readNotes() async {
    List<Note> readNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(readNotes);
    notifyListeners();
  }

  // U P D A T E
  Future<void> updateNote(
    int id,
    String titleFromuser,
    String contentFromuser,
  ) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = titleFromuser;
      existingNote.content = contentFromuser;
      existingNote.updatedAt = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));

      await readNotes();
    }
  }

  // D E L E T E
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));

    await readNotes();
  }
}
