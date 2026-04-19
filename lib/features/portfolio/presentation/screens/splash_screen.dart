import 'dart:async';
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

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  String _displayedText = "";
  final String _fullText = "> Initializing Senior Architect Portfolio...";
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _logoController.forward();
    _startTyping();
    _navigateToHome();
  }

  void _startTyping() {
    int index = 0;
    _typingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (index < _fullText.length) {
        setState(() {
          _displayedText += _fullText[index];
          index++;
        });
      } else {
        _typingTimer?.cancel();
      }
    });
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, animation, secondaryAnimation) => const PortfolioScaffold(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  void dispose() {
    _logoController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeNotifierProvider) == ThemeMode.dark;
    final primaryColor = isDark ? const Color(0xFF22D3EE) : const Color(0xFF4F46E5);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Draw Animation
            SizedBox(
              width: 100,
              height: 100,
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LogoDrawPainter(
                      progress: _logoController.value,
                      color: primaryColor,
                    ),
                  );
                },
              ),
            )
            .animate()
            .shimmer(delay: 2500.ms, duration: 1000.ms),
            
            const SizedBox(height: 48),
            
            // Terminal typing effect
            SizedBox(
              height: 24,
              child: Text(
                _displayedText,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white70 : Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            // Animated Cursor
            const SizedBox(height: 8),
            Container(
              width: 12,
              height: 4,
              color: primaryColor,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .fade(duration: 500.ms, begin: 0, end: 1, curve: Curves.easeInOutSine),
          ],
        ),
      ),
    );
  }
}

class LogoDrawPainter extends CustomPainter {
  final double progress;
  final Color color;

  LogoDrawPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Draw '<'
    if (progress > 0) {
      double p1 = (progress * 3).clamp(0.0, 1.0);
      path.moveTo(size.width * 0.3, size.height * 0.35);
      path.lineTo(size.width * 0.15, size.height * 0.5);
      path.lineTo(size.width * 0.3, size.height * 0.65);
    }

    // Draw '/'
    if (progress > 0.33) {
      double p2 = ((progress - 0.33) * 3).clamp(0.0, 1.0);
      path.moveTo(size.width * 0.6, size.height * 0.25);
      path.lineTo(size.width * 0.4, size.height * 0.75);
    }

    // Draw '>'
    if (progress > 0.66) {
      double p3 = ((progress - 0.66) * 3).clamp(0.0, 1.0);
      path.moveTo(size.width * 0.7, size.height * 0.35);
      path.lineTo(size.width * 0.85, size.height * 0.5);
      path.lineTo(size.width * 0.7, size.height * 0.65);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LogoDrawPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
