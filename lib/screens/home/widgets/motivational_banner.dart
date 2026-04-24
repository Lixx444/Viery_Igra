import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/profile_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/motivational_quotes.dart';
import '../../../widgets/glass_card.dart';

class MotivationalBanner extends StatefulWidget {
  const MotivationalBanner({super.key});

  @override
  State<MotivationalBanner> createState() => _MotivationalBannerState();
}

class _MotivationalBannerState extends State<MotivationalBanner> {
  late int _quoteIndex;

  @override
  void initState() {
    super.initState();
    _quoteIndex = Random().nextInt(quoteCount);
  }

  void _nextQuote() {
    setState(() {
      _quoteIndex = (_quoteIndex + 1) % quoteCount;
    });
  }

  void _onAvatarTap(ProfileProvider profile) {
    if (!profile.hasImage) {
      profile.pickImage();
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.changePicture),
              onTap: () {
                Navigator.pop(context);
                profile.pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: Text(l10n.removePicture),
              onTap: () {
                Navigator.pop(context);
                profile.removeImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final l10n = AppLocalizations.of(context)!;
    final quotes = localizedQuotes(l10n);

    return GestureDetector(
      onTap: _nextQuote,
      child: GlassCard(
        child: Row(
          children: [
            // Profile picture
            GestureDetector(
              onTap: () => _onAvatarTap(profile),
              child: Container(
                key: ValueKey(profile.imageVersion),
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                  image: profile.hasImage
                      ? DecorationImage(
                          image: FileImage(File(profile.imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: profile.hasImage
                    ? null
                    : const Icon(
                        Icons.add_a_photo_outlined,
                        size: 28,
                        color: AppColors.accent,
                      ),
              ),
            ),
            const SizedBox(width: 14),
            // Quote text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      quotes[_quoteIndex],
                      key: ValueKey(_quoteIndex),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.tapForMore,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
