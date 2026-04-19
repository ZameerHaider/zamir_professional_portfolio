import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'glass_container.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> skills = {
      'Core Technologies': ['Flutter', 'Dart', 'Xcode', 'Android Studio', 'FlutterFlow'],
      'Architecture & State': ['Riverpod', 'Bloc', 'Clean Architecture', 'MVVM', 'Server-Driven UI'],
      'Networking & Cloud': ['Firebase', 'AWS Amplify', 'RESTful APIs', 'GraphQL', 'Node.js'],
      'Hardware & Payments': ['Sunmi POS', 'Thermal Printing', 'HalaPay', 'SurePay', 'NearPay'],
      'Tools & Deployment': ['Git', 'CI/CD', 'App Store Connect', 'Google Play Console'],
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
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: 24),
          ...skills.entries.toList().asMap().entries.map((categoryEntry) {
            final categoryIndex = categoryEntry.key;
            final entry = categoryEntry.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))
                      .animate().fadeIn(delay: (200 * categoryIndex).ms, duration: 400.ms),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: entry.value.asMap().entries.map((skillEntry) {
                      final skillIndex = skillEntry.key;
                      final skill = skillEntry.value;
                      
                      return Chip(
                        label: Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                      ).animate()
                       .fadeIn(delay: (200 * categoryIndex + 50 * skillIndex).ms, duration: 400.ms)
                       .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack);
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
