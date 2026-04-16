import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart';
import 'portfolio_scaffold.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, animation, secondaryAnimation) => const PortfolioScaffold(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade Scale Transition
          var curve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(
            opacity: curve,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(curve),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Draw Animation
            Icon(
              Icons.terminal_rounded, 
              size: 80, 
              color: isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5)
            )
            .animate()
            .scale(duration: 800.ms, curve: Curves.easeOutBack)
            .then(delay: 200.ms)
            .shimmer(duration: 1000.ms),
            
            const SizedBox(height: 32),
            
            // Terminal typing effect
            Text(
              '> Initializing Senior Architect Portfolio...',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            )
            .animate(delay: 1000.ms)
            .fade(duration: 800.ms)
            .slideX(begin: -0.1, end: 0, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}
