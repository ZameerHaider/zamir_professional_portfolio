import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_providers.dart';
import 'glass_container.dart';

class ExperienceTimeline extends ConsumerWidget {
  const ExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experienceAsync = ref.watch(experienceProvider);

    return experienceAsync.when(
      data: (experiences) {
        if (experiences.isEmpty) return const SizedBox.shrink();
        
        return GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.work, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 12),
                  Text('Professional Experience', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 32),
              ...experiences.map((exp) => Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 10 + (exp.accomplishments.join("").length * 0.5).clamp(80.0, 300.0), // Dynamic trace line
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exp.position, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('${exp.company} • ${exp.period}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor)),
                          const SizedBox(height: 16),
                          ...exp.accomplishments.map((acc) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.arrow_right, size: 20, color: Theme.of(context).primaryColor),
                                const SizedBox(width: 8),
                                Expanded(child: Text(acc, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5))),
                              ],
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error loading experience: $err', style: const TextStyle(color: Colors.red)),
    );
  }
}
