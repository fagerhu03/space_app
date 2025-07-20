import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class PlanetDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const PlanetDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header image with planet name and title
              Stack(
                children: [
                  Image.asset(
                    'assets/image/Rectangle 4.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        data['Planet Name'] ?? 'Unknown Planet',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 8,
                    child: Text(
                      data['Title'] ?? '',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 3D model viewer
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ModelViewer(
                  src: 'assets/models/${data['3D Model'] ?? 'earth.glb'}',
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: 32),

              // About section
              const Text(
                "About",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data['About'] ?? 'No description available.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 32),

              // Planet data
              _buildStat("Distance from Sun", data['Distance from Sun (km)'], "km"),
              _buildStat("Length of Day", data['Length of Day (hours)'], "hours"),
              _buildStat("Orbital Period", data['Orbital Period (Earth years)'], "Earth years"),
              _buildStat("Radius", data['Radius (km)'], "km"),
              _buildStat("Mass", data['Mass (kg)'], "kg"),
              _buildStat("Gravity", data['Gravity (m/s²)'], "m/s²"),
              _buildStat("Surface Area", data['Surface Area (km²)'], "km²"),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String? value, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value != null ? "$value $unit" : "-",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

// FIXED: Use this in navigation_push_example.dart
final List<Map<String, dynamic>> planetData = [
  {
    "Planet Name": "Mercury",
    "3D Model": "mercury.glb",
    "Title": "Mercury: The Closest Planet",
    "About": "Mercury is the smallest planet in our solar system and nearest to the Sun...",
    "Distance from Sun (km)": "57,909,227",
    "Length of Day (hours)": "1407.60",
    "Orbital Period (Earth years)": "0.24",
    "Radius (km)": "2,439.70",
    "Mass (kg)": "3.301 × 10²³",
    "Gravity (m/s²)": "3.70",
    "Surface Area (km²)": "7.48 × 10⁷",
  },
  // Add other planets here...
];

void navigateToPlanetDetail(BuildContext context, String planetName) {
  final selectedPlanetData = planetData.firstWhere(
        (planet) => planet['Planet Name'].toLowerCase() == planetName.toLowerCase(),
      orElse: () => {
      "Planet Name": "Unknown",
      "3D Model": "earth.glb",
      "Title": "Data not found",
      "About": "Sorry, no information is available for this planet.",
      "Distance from Sun (km)": "-",
      "Length of Day (hours)": "-",
      "Orbital Period (Earth years)": "-",
      "Radius (km)": "-",
      "Mass (kg)": "-",
      "Gravity (m/s²)": "-",
      "Surface Area (km²)": "-",


    },
  );

  if (selectedPlanetData != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanetDetailScreen(data: selectedPlanetData),
      ),
    );
  }
}
