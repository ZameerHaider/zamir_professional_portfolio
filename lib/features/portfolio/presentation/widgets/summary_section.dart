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
            "Flutter developer with 5+ years of production experience — I don't just build apps, I ship them.\n\n"
            "I have multiple live apps on the Apple App Store, including Ignite (an enterprise business platform). Apps used by real businesses and real users.\n\n"
            "I specialize in crafting robust, scalable, and highly aesthetic cross-platform applications with native performance. My expertise spans the entire development lifecycle — from architectural design and backend integration (Firebase, AWS Amplify) to payment terminal implementations and store deployment.\n\n"
            "Currently Senior Flutter Architect at Ignite, focusing on enterprise-scale solutions and innovative POS systems.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
