import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/note_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_fab.dart';
import 'note_add_edit_screen.dart';
import 'widgets/note_card.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  void _openEditor(BuildContext context, {note}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NoteAddEditScreen(note: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteProvider>().notes;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notesTitle)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final characterHeight = constraints.maxHeight * 0.45;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Character — flush with bottom
              Positioned(
                bottom: 0,
                left: 10,
                child: Image.asset(
                  'assets/images/characters/yagami_light.png',
                  height: characterHeight,
                  fit: BoxFit.contain,
                ),
              ),
              // Content
              if (notes.isEmpty)
                Center(
                  child: Text(
                    l10n.noNotesYet,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 16,
                    ),
                  ),
                )
              else
                ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 80),
                  itemCount: notes.length,
                  itemBuilder: (_, i) => NoteCard(
                    note: notes[i],
                    onTap: () => _openEditor(context, note: notes[i]),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: AppFab(onPressed: () => _openEditor(context)),
    );
  }
}
