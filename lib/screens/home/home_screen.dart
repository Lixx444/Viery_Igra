import 'package:flutter/material.dart';

import 'widgets/clock_widget.dart';
import 'widgets/date_widget.dart';
import 'widgets/motivational_banner.dart';
import 'widgets/todays_tasks_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final characterHeight = constraints.maxHeight * 0.45;
        return Stack(
          fit: StackFit.expand,
          children: [
              // Character
              Positioned(
                bottom: 0,
                right: 10,
                child: Image.asset(
                  'assets/images/characters/satoru_gojo.png',
                  height: characterHeight,
                  fit: BoxFit.contain,
                ),
              ),
              // Scrollable content with safe area padding
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Clock + Date row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const ClockWidget(),
                            const SizedBox(width: 12),
                            const DateWidget(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Today's tasks summary
                      const TodaysTasksSummary(),
                      const SizedBox(height: 12),
                      // Motivational banner
                      const MotivationalBanner(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
  }
}
