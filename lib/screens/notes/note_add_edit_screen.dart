import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';
import '../../providers/note_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/date_utils.dart' as app_date;

class NoteAddEditScreen extends StatefulWidget {
  final Note? note;

  const NoteAddEditScreen({super.key, this.note});

  @override
  State<NoteAddEditScreen> createState() => _NoteAddEditScreenState();
}

class _NoteAddEditScreenState extends State<NoteAddEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late bool _previewMode;

  bool get isEditing => widget.note != null;

  bool get _hasUnsavedChanges {
    if (isEditing) {
      return _titleController.text.trim() != widget.note!.title.trim() ||
          _bodyController.text.trim() != widget.note!.body.trim();
    }
    return _titleController.text.trim().isNotEmpty ||
        _bodyController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _previewMode = isEditing;
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _bodyController = TextEditingController(text: widget.note?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _handleDiscard() async {
    if (!_hasUnsavedChanges) {
      Navigator.pop(context);
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.discardNote),
        content: Text(l10n.discardNoteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.discard,
                style: const TextStyle(color: AppColors.priorityHigh)),
          ),
        ],
      ),
    );
    if (shouldDiscard == true && mounted) {
      Navigator.pop(context);
    }
  }

  void _save() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) return;

    final provider = context.read<NoteProvider>();
    final now = DateTime.now();

    if (isEditing) {
      final updated = widget.note!.copyWith(
        title: title,
        body: body,
        updatedAt: now,
      );
      provider.updateNote(updated);
    } else {
      final note = Note(
        id: const Uuid().v4(),
        title: title,
        body: body,
        createdAt: now,
        updatedAt: now,
      );
      provider.addNote(note);
    }

    Navigator.pop(context);
  }

  void _confirmDelete() {
    if (!isEditing) return;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteNote),
        content: Text(l10n.deleteNoteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<NoteProvider>().deleteNote(widget.note!.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text(l10n.delete,
                style: const TextStyle(color: AppColors.priorityHigh)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleDiscard();
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.editNote : l10n.newNote),
        actions: [
          IconButton(
            icon: Icon(_previewMode ? Icons.edit_outlined : Icons.visibility_outlined),
            onPressed: () => setState(() => _previewMode = !_previewMode),
            tooltip: _previewMode ? l10n.editTooltip : l10n.previewTooltip,
          ),
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.priorityHigh,
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isEditing)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  l10n.lastEdit(app_date.formatDateTime(widget.note!.updatedAt)),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ),
            TextField(
              controller: _titleController,
              autofocus: !isEditing,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: l10n.noteNameHint,
                border: InputBorder.none,
                filled: false,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const Divider(color: AppColors.dashedBorder),
            Expanded(
              child: _previewMode
                  ? Markdown(
                      data: _bodyController.text.isEmpty
                          ? l10n.nothingToPreview
                          : _bodyController.text.replaceAll('\n', '  \n'),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                            fontFamily: 'Caveat', fontSize: 18, color: AppColors.textSecondary),
                        h1: TextStyle(
                            fontFamily: 'Caveat', fontSize: 26, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        h2: TextStyle(
                            fontFamily: 'Caveat', fontSize: 23, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        h3: TextStyle(
                            fontFamily: 'Caveat', fontSize: 20, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                        code: TextStyle(
                          fontSize: 13,
                          backgroundColor:
                              AppColors.accentLight.withValues(alpha: 0.3),
                        ),
                        blockquoteDecoration: BoxDecoration(
                          color: AppColors.accentLight.withValues(alpha: 0.2),
                          border: Border(
                            left: BorderSide(color: AppColors.accent, width: 3),
                          ),
                        ),
                      ),
                    )
                  : TextField(
                      controller: _bodyController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.noteTextHint,
                        border: InputBorder.none,
                        filled: false,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(isEditing ? l10n.update : l10n.save),
          ),
        ),
      ),
    ),
    );
  }
}

