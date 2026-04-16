import 'package:flutter/material.dart';
import 'glass_container.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> skills = {
      'Core Technologies': ['Flutter', 'Dart', 'Xcode', 'Android Studio'],
      'Architecture & State': ['Provider', 'Bloc', 'GetX', 'Clean Architecture', 'MVVM', 'MVC'],
      'Networking & Cloud': ['Firebase', 'RESTful APIs', 'GraphQL', 'Firestore', 'Amplify'],
      'Payments & Tools': ['Tabby', 'Tamara', 'Nearpay', 'OneSignal', 'Git'],
    };

    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Theme.of(context).primaryColor),
              const SizedBox(width: 12),
              Text('Technical Skills', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          ...skills.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: entry.value.map((skill) => Chip(
                    label: Text(skill),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  )).toList(),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
