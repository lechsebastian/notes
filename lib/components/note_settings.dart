import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onUpdateTap;
  final void Function()? onDeleteTap;
  const NoteSettings({
    super.key,
    required this.onUpdateTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onUpdateTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(child: Text('Edit')),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(child: Text('Delete')),
          ),
        ),
      ],
    );
  }
}
