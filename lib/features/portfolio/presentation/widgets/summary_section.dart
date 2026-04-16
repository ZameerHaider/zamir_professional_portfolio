import 'package:flutter/material.dart';
import 'glass_container.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).primaryColor),
              const SizedBox(width: 12),
              Text('Professional Summary', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Senior Flutter Developer with over 5 years of experience crafting high-quality cross-platform mobile applications. Proficient in Flutter and Dart, with a strong focus on responsive UI/UX design. Expertise in state management using Provider, GetX, and BLoC, along with a solid background integrating Firebase, RESTful, and GraphQL APIs. I specialize in building scalable enterprise architectures, leading teams, mentoring peers, and driving robust project success natively on iOS, Android, and Web.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
