import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/experience.dart';
import '../../domain/repositories/i_portfolio_repository.dart';

class JsonPortfolioRepository implements IPortfolioRepository {
  final String _assetPath = 'assets/specs/portfolio_config.json';

  Future<Map<String, dynamic>> _loadJson() async {
    try {
      final jsonString = await rootBundle.loadString(_assetPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return {'projects': [], 'experience': []};
    }
  }

  @override
  Stream<List<Project>> streamProjects() async* {
    final data = await _loadJson();
    final projectsList = data['projects'] as List<dynamic>? ?? [];
    final projects = projectsList.map((e) => Project.fromJson(e as Map<String, dynamic>)).toList();
    projects.sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    yield projects;
  }

  @override
  Stream<List<Experience>> streamExperience() async* {
    final data = await _loadJson();
    final expList = data['experience'] as List<dynamic>? ?? [];
    yield expList.map((e) => Experience.fromJson(e as Map<String, dynamic>)).toList();
  }
}
