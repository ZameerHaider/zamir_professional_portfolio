import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/portfolio_providers.dart';
import 'glass_container.dart';

class ProjectGrid extends ConsumerWidget {
  const ProjectGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return projectsAsync.when(
      data: (projects) {
        final width = MediaQuery.of(context).size.width;
        int crossAxisCount;
        if (width < 600) {
          crossAxisCount = 1;
        } else if (width < 1024) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 4;
        }

        return StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          children: [
            for (int i = 0; i < projects.length; i++)
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: ProjectCard(project: projects[i], index: i),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF22D3EE))),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final dynamic project;
  final int index;
  const ProjectCard({Key? key, required this.project, required this.index}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: GlassContainer(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.project.role, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 16),
                    Flexible(
                      child: Text(
                        widget.project.description,
                        maxLines: _isHovered ? 10 : 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),

              // Tech Stack Overlay on Hover
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                bottom: _isHovered ? 0 : -100,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Theme.of(context).primaryColor.withOpacity(0.9), Theme.of(context).primaryColor.withOpacity(0.0)],
                    ),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.techStack
                        .map<Widget>(
                          (tech) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Text(
                              tech.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (100 * widget.index).ms, duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);
  }
}
