import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_providers.dart';
import 'glass_container.dart';

class ProjectGrid extends ConsumerWidget {
  const ProjectGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      data: (projects) {
        if (projects.isEmpty) {
          return const Center(child: Text("No projects found. Check configuration."));
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.8,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF22D3EE))),
                  const SizedBox(height: 8),
                  Text(project.role, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Expanded(child: Text(project.description)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.techStack.map((tech) => Chip(
                      label: Text(tech, style: const TextStyle(fontSize: 12)),
                      backgroundColor: const Color(0xFF22D3EE).withOpacity(0.1),
                      side: const BorderSide(color: Color(0xFF22D3EE), width: 0.5),
                    )).toList(),
                  )
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF22D3EE))),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
