class ResumeEntity {
  final String id;
  final String version;
  final String assetPath;
  final DateTime lastUpdated;

  const ResumeEntity({
    required this.id,
    required this.version,
    required this.assetPath,
    required this.lastUpdated,
  });
}
