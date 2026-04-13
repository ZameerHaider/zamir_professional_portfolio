import '../entities/project.dart';
import '../entities/experience.dart';

abstract class IPortfolioRepository {
  Stream<List<Project>> streamProjects();
  Stream<List<Experience>> streamExperience();
}
