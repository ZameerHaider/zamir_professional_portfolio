import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamir_professional_portfolio/features/resume/domain/entities/resume_entity.dart';

final resumeProvider = Provider<ResumeEntity>((ref) {
  return ResumeEntity(
    id: 'zamir_cv',
    version: '1.0.0',
    assetPath: 'assets/resume/zamir_haider_resume.pdf',
    lastUpdated: DateTime.now(),
  );
});
