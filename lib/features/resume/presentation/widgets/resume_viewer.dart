import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/glass_container.dart';
import 'package:zamir_professional_portfolio/features/resume/presentation/providers/resume_provider.dart';

class ResumeViewer extends ConsumerWidget {
  const ResumeViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(resumeProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text('Professional Resume', 
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)
            ),
          ],
        ).animate().fadeIn().slideX(begin: -0.1, end: 0),
        const SizedBox(height: 24),
        
        GlassContainer(
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black12,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: PdfViewer.asset(
                resume.assetPath,
                params: const PdfViewerParams(
                  enableTextSelection: true,
                  maxScale: 3.0,
                ),
              ),
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
      ],
    );
  }
}
