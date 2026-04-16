import 'package:cloud_firestore/cloud_firestore.dart';
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
      return _firestoreRepo.streamProjects();
    }
    return _jsonRepo.streamProjects();
  }

  Future<void> seedFirestore() async {
    try {
      final projects = await _jsonRepo.streamProjects().first;
      for (final project in projects) {
        final data = project.toJson();
        final Object? id = data.remove('id');
        await FirebaseFirestore.instance.collection('projects').doc(id.toString()).set(data);
      }
      print('Seeding Complete!');
    } catch (e) {
      print('Seeding Error: $e');
    }
  }

  @override
  Stream<List<Experience>> streamExperience() {
    if (useFirestore) {
      return _firestoreRepo.streamExperience();
    }
    return _jsonRepo.streamExperience();
  }
}
