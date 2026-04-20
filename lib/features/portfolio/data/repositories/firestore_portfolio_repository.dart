import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/experience.dart';
import '../../domain/repositories/i_portfolio_repository.dart';

class FirestorePortfolioRepository implements IPortfolioRepository {
  final FirebaseFirestore _firestore;

  FirestorePortfolioRepository({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Project>> streamProjects() {
    return _firestore.collection('projects').orderBy('order').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Map document ID
        return Project.fromJson(data);
      }).toList();
    });
  }

  @override
  Stream<List<Experience>> streamExperience() {
    return _firestore.collection('experience').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Map document ID
        return Experience.fromJson(data);
      }).toList();
    });
  }
}
