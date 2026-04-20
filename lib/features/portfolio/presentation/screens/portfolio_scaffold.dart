import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'package:zamir_professional_portfolio/core/theme/theme_provider.dart';
import 'package:zamir_professional_portfolio/core/responsive_config.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/experience_timeline.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/project_grid.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/skills_section.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/summary_section.dart';
import 'package:zamir_professional_portfolio/features/resume/presentation/widgets/resume_viewer.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';

class PortfolioScaffold extends ConsumerStatefulWidget {
  const PortfolioScaffold({Key? key}) : super(key: key);

  @override
  ConsumerState<PortfolioScaffold> createState() => _PortfolioScaffoldState();
}

class _PortfolioScaffoldState extends ConsumerState<PortfolioScaffold> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _resumeKey = GlobalKey();

  String _activeSection = 'About';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final sections = {'About': _heroKey, 'Skills': _skillsKey, 'Experience': _experienceKey, 'Projects': _projectsKey, 'Resume': _resumeKey};

    String currentSection = _activeSection;
    double minDistance = double.infinity;

    sections.forEach((name, key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        if (position.abs() < minDistance) {
          minDistance = position.abs();
          currentSection = name;
        }
      }
    });

    if (currentSection != _activeSection) {
      setState(() {
        _activeSection = currentSection;
      });
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubic);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _navButton(String label, GlobalKey sectionKey, {bool isDrawer = false}) {
    final isActive = _activeSection == label;
    final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;

    return InkWell(
      onTap: () {
        if (isDrawer) Navigator.pop(context);
        _scrollTo(sectionKey);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isDrawer ? 16 : 0, horizontal: isDrawer ? 24 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isDrawer ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: isDrawer ? 18 : 14,
                color: isActive ? (isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5)) : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
            if (!isDrawer) ...[
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: isActive ? 20 : 0,
                color: isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5),
              ),
            ],
          ],
        ),
      ),
    ).animate(target: isActive ? 1.0 : 0.0).scale(
      begin: const Offset(1, 1),
      end: const Offset(1.05, 1.05),
      duration: 300.ms,
      curve: Curves.easeOutBack
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;
    final isMobile = ResponsiveConfig.isMobile(context);
    final isDesktop = ResponsiveConfig.isDesktop(context);

    return Scaffold(
      drawer: isMobile ? Drawer(
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text('ZAMEER', style: TextStyle(
                  color: isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5),
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: 4,
                )),
              ),
            ),
            _navButton('About', _heroKey, isDrawer: true),
            _navButton('Skills', _skillsKey, isDrawer: true),
            _navButton('Experience', _experienceKey, isDrawer: true),
            _navButton('Projects', _projectsKey, isDrawer: true),
            _navButton('Resume', _resumeKey, isDrawer: true),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const FaIcon(FontAwesomeIcons.github), onPressed: () => _launchUrl('https://github.com/zameerhaider')),
                  IconButton(icon: const FaIcon(FontAwesomeIcons.linkedin), onPressed: () => _launchUrl('https://linkedin.com/in/zameerhaider')),
                ],
              ),
            ),
          ],
        ),
      ) : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: isMobile ? 300.0 : 400.0,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
                leading: isMobile ? Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ) : null,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark ? [const Color(0xFF0F172A), const Color(0xFF1E293B)] : [const Color(0xFFF8FAFC), Colors.white],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              'Zameer | Senior Flutter Architect',
                              style: TextStyle(
                                fontWeight: FontWeight.w900, 
                                fontSize: isMobile ? 28 : 42,
                              ),
                              textAlign: TextAlign.center,
                            ).animate().fade(duration: 800.ms).slideY(begin: 0.2, end: 0),
                            const SizedBox(height: 16),
                            Text(
                              "Crafting robust, scalable, and highly aesthetic cross-platform applications.",
                              style: (isMobile ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleLarge)?.copyWith(
                                color: isDark ? Colors.white70 : Colors.black54
                              ),
                              textAlign: TextAlign.center,
                            ).animate(delay: 200.ms).fade(duration: 800.ms).slideY(begin: 0.2, end: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  Consumer(
                    builder: (context, ref, _) {
                      final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;
                      return IconButton(
                        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.amber : Colors.indigo),
                        onPressed: () => ref.read(themeModeNotifierProvider.notifier).toggleTheme(),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : (isDesktop ? 64 : 32), 
                  vertical: 64
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SummarySection(key: _heroKey),
                    const SizedBox(height: 80),

                    SkillsSection(key: _skillsKey),
                    const SizedBox(height: 80),

                    ExperienceTimeline(key: _experienceKey),
                    const SizedBox(height: 80),

                    Text(
                      "Selected Projects",
                      key: _projectsKey,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 24 : 32,
                      ),
                    ).animate().fade().slideX(begin: -0.1, end: 0),
                    const SizedBox(height: 32),
                    const ProjectGrid(),
                    const SizedBox(height: 80),

                    ResumeViewer(key: _resumeKey),
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),
          
          if (!isMobile)
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: AppTheme.glassDecoration(context).copyWith(borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ZAMIR',
                        style: TextStyle(
                          color: isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5), 
                          fontWeight: FontWeight.w900, 
                          letterSpacing: 2, 
                          fontSize: 16
                        ),
                      ),
                      const SizedBox(width: 24),
                      const VerticalDivider(width: 1, indent: 8, endIndent: 8, color: Colors.white24),
                      const SizedBox(width: 12),
                      _navButton('About', _heroKey),
                      const SizedBox(width: 12),
                      _navButton('Skills', _skillsKey),
                      const SizedBox(width: 12),
                      _navButton('Experience', _experienceKey),
                      const SizedBox(width: 12),
                      _navButton('Projects', _projectsKey),
                      const SizedBox(width: 12),
                      _navButton('Resume', _resumeKey),
                      const SizedBox(width: 24),
                      const VerticalDivider(width: 1, indent: 8, endIndent: 8, color: Colors.white24),
                      const SizedBox(width: 24),

                      IconButton(
                        icon: const Icon(Icons.sync, size: 20),
                        onPressed: () => ref.read(dataServiceProvider).seedFirestore(),
                        tooltip: 'Sync Firestore (Dev Only)',
                      ),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.github, size: 20), onPressed: () => _launchUrl('https://github.com/zameerhaider'), tooltip: 'GitHub'),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.linkedin, size: 20), onPressed: () => _launchUrl('https://linkedin.com/in/zameerhaider'), tooltip: 'LinkedIn'),
                      const SizedBox(width: 12),

                      ElevatedButton.icon(
                        onPressed: () => _launchUrl('assets/resume/zamir_haider_resume.pdf'),
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Download CV'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ).animate().shimmer(delay: 2.seconds, duration: 1.seconds),
                    ],
                  ),
                ).animate().fade(duration: 500.ms).slideY(begin: -1, end: 0),
              ),
            ),
        ],
      ),
    );
  }
}
