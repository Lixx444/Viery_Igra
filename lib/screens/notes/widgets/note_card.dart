import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../models/note.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/date_utils.dart' as app_date;
import '../../../widgets/dashed_border_container.dart';
import '../../../widgets/glass_card.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: DashedBorderContainer(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isNotEmpty ? note.title : AppLocalizations.of(context)!.untitled,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (note.body.isNotEmpty) ...[
                const SizedBox(height: 6),
                MarkdownBody(
                  data: note.body.length > 150
                      ? '${note.body.substring(0, 150)}...'
                      : note.body,
                  shrinkWrap: true,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(
                        fontFamily: 'Caveat', fontSize: 15, color: AppColors.textSecondary),
                    h1: const TextStyle(
                        fontFamily: 'Caveat', fontSize: 17, color: AppColors.textPrimary),
                    h2: const TextStyle(
                        fontFamily: 'Caveat', fontSize: 16, color: AppColors.textPrimary),
                    code: TextStyle(
                      fontSize: 12,
                      backgroundColor:
                          AppColors.accentLight.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                app_date.formatDateShort(note.updatedAt),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
