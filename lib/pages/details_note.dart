import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class DetailsNotePage extends StatefulWidget {
  final Note? note;
  final bool isExistingNote;

  const DetailsNotePage({
    super.key,
    required this.note,
    required this.isExistingNote,
  });

  @override
  State<DetailsNotePage> createState() => _DetailsNotePageState();
}

class _DetailsNotePageState extends State<DetailsNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  void back() {
    titleController.clear();
    contentController.clear();
    Navigator.of(context).pop();
  }

  void saveOrUpdate() async {
    final noteDB = context.read<NoteDatabase>();

    if (widget.isExistingNote && widget.note != null) {
      await noteDB.updateNote(
        id: widget.note!.id,
        titleFromUser: titleController.text,
        contentFromUser: contentController.text,
      );
    } else {
      await noteDB.createNote(titleController.text, contentController.text);
    }

    back();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  bool get isFilled =>
      titleController.text.isNotEmpty && contentController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: back, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(widget.isExistingNote ? 'Edit Note' : 'Create Note'),
        actions: [
          ValueListenableBuilder(
            valueListenable: titleController,
            builder:
                (context, _, __) => ValueListenableBuilder(
                  valueListenable: contentController,
                  builder:
                      (context, _, __) => IconButton(
                        onPressed: isFilled ? saveOrUpdate : null,
                        icon: const Icon(Icons.done),
                      ),
                ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Title',
                  alignLabelWithHint: true,
                ),
                maxLength: 40,
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                    hintText: 'Content',
                    alignLabelWithHint: true,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  maxLength: 1000,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
