import '../../domain/entities/project.dart';
import '../../domain/entities/experience.dart';
import '../../domain/repositories/i_portfolio_repository.dart';
import 'firestore_portfolio_repository.dart';
import 'json_portfolio_repository.dart';

class DataService implements IPortfolioRepository {
  final FirestorePortfolioRepository _firestoreRepo;
  final JsonPortfolioRepository _jsonRepo;
  final bool useFirestore;

  DataService({
    required FirestorePortfolioRepository firestoreRepo,
    required JsonPortfolioRepository jsonRepo,
    this.useFirestore = true,
  })  : _firestoreRepo = firestoreRepo,
        _jsonRepo = jsonRepo;

  @override
  Stream<List<Project>> streamProjects() {
    if (useFirestore) {
      // Fallback to json if firestore stream emits an error
      return _firestoreRepo.streamProjects().handleError((error) {
        return _jsonRepo.streamProjects();
      });
    }
    return _jsonRepo.streamProjects();
  }

  @override
  Stream<List<Experience>> streamExperience() {
    if (useFirestore) {
      return _firestoreRepo.streamExperience().handleError((error) {
        return _jsonRepo.streamExperience();
      });
    }
    return _jsonRepo.streamExperience();
  }
}
