import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/note_settings.dart';
import 'package:notes/models/note.dart';
import 'package:popover/popover.dart';

class MyNoteTile extends StatelessWidget {
  final Note note;
  final void Function()? onUpdatePress;
  final void Function()? onDeletePress;
  const MyNoteTile({
    super.key,
    required this.note,
    required this.onUpdatePress,
    required this.onDeletePress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: AutoSizeText(
          note.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          maxLines: 1,
          minFontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: AutoSizeText(
          note.content,
          maxLines: 3,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.more_vert),
              onPressed:
                  () => showPopover(
                    width: 100,
                    height: 100,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    bodyBuilder:
                        (context) => NoteSettings(
                          onUpdateTap: onUpdatePress,
                          onDeleteTap: onDeletePress,
                        ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
