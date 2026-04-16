import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../data/repositories/json_portfolio_repository.dart';
import '../widgets/project_grid.dart';
import '../widgets/architecture_depth.dart';
import '../widgets/summary_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_timeline.dart';

class PortfolioScaffold extends StatelessWidget {
  const PortfolioScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient decoration
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF22D3EE).withOpacity(0.12),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF22D3EE).withOpacity(0.2), blurRadius: 300, spreadRadius: 100)
                ]
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          const Text('Zamir | Senior Flutter Architect', 
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text("Crafting robust, scalable, and highly aesthetic cross-platform applications.", 
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black87
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  Consumer(
                    builder: (context, ref, _) {
                      final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;
                      return IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return RotationTransition(
                              turns: animation,
                              child: ScaleTransition(scale: animation, child: child),
                            );
                          },
                          child: Icon(
                            isDark ? Icons.light_mode : Icons.dark_mode,
                            key: ValueKey<bool>(isDark),
                            color: isDark ? Colors.amber : Colors.indigo,
                          ),
                        ),
                        onPressed: () {
                          ref.read(themeModeNotifierProvider.notifier).toggleTheme();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SummarySection(),
                    const SizedBox(height: 48),

                    const SkillsSection(),
                    const SizedBox(height: 48),

                    const ExperienceTimeline(),
                    const SizedBox(height: 48),

                    Text("Selected Projects", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    const ProjectGrid(),
                    const SizedBox(height: 64),

                    Text("Architectural Overview", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    const ArchitectureDepth(),
                    const SizedBox(height: 64),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final jsonRepo = JsonPortfolioRepository();
          // Seed Projects
          jsonRepo.streamProjects().first.then((projects) {
            for (final project in projects) {
              final data = project.toJson();
              final id = data.remove('id');
              FirebaseFirestore.instance.collection('projects').doc(id.toString()).set(data);
            }
          });
          
          // Seed Experience
          jsonRepo.streamExperience().first.then((expList) {
            for (final exp in expList) {
              final data = exp.toJson();
              final id = data.remove('id');
              FirebaseFirestore.instance.collection('experience').doc(id.toString()).set(data);
            }
            print('Successfully seeded 100% of Zamir\'s CV from JSON to Firestore!');
          });
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
