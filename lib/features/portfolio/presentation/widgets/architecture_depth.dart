import 'package:flutter/material.dart';
import 'glass_container.dart';

class ArchitectureDepth extends StatelessWidget {
  const ArchitectureDepth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.architecture, color: Color(0xFF22D3EE), size: 32),
              const SizedBox(width: 16),
              Text(
                "Clean Architecture Breakdown",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("This portfolio is built with enterprise-grade standards to demonstrate architectural proficiency:"),
          const SizedBox(height: 24),
          _buildFeature(Icons.layers, "Layered Design", "Strict separation of Domain, Data, and Presentation layers. No domain logic leaks into the UI."),
          _buildFeature(Icons.waves, "Reactive State", "Riverpod (@riverpod) is used for immutable, unidirectional data flow and compile-safe providers."),
          _buildFeature(Icons.lock, "Immutability", "All Entities and Data Models are frozen with @freezed, ensuring robust state integrity."),
          _buildFeature(Icons.data_usage, "Mockable Data", "Data sources abstract Firestore streams with native JSON fallbacks for complete offline development."),
          _buildFeature(Icons.brush, "Design System", "A custom Dark/Tech glassmorphism theme using Material 3 and BackdropFilters."),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF22D3EE), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
