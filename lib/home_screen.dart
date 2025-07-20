import 'package:flutter/material.dart';

class Planet {
  final String name;
  final String imageAsset;

  Planet(this.name, this.imageAsset);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int currentIndex = 0;

  final List<Planet> planets = [
    Planet("Mercury", "assets/image/mercury.png"),
    Planet("Venus", "assets/image/venus.png"),
    Planet("Earth", "assets/image/earth.png"),
    Planet("Mars", "assets/image/mars.png"),
    Planet("Jupiter", "assets/image/jupiter.png"),
    Planet("Saturn", "assets/image/saturn.png"),
    Planet("Uranus", "assets/image/uranus.png"),
    Planet("Neptune", "assets/image/neptune.png"),
  ];

  void nextPage() {
    if (currentIndex < planets.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final planet = planets[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header with background, gradient and stacked text
          Stack(
            children: [
              Image.asset(
                'assets/image/Rectangle 4.png',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Explore",style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,),
                  ),
                ),
              ),
              const Positioned(
                left: 24,
                bottom: 1,
                child: Text(
                  "Which planet\nwould you like to explore?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: planets.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = planets[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(item.imageAsset, height: 340),
                    const SizedBox(height: 32),
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: previousPage,
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.arrow_back,color: Colors.white,),
              ),
              FloatingActionButton(
                onPressed: nextPage,
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.arrow_forward,color: Colors.white,),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/planetDetail',
                    arguments: planet,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Explore ${planet.name}", style: const TextStyle(fontSize: 18,color: Colors.white,)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward,color: Colors.white,),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}