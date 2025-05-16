import 'package:flutter/material.dart';
import '../shape/custom_shape.dart';


void main() {
  runApp(const AboutDearo());
}

class AboutDearo extends StatelessWidget {
  const AboutDearo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutDearoScreen(),
    );
  }
}

class AboutDearoScreen extends StatelessWidget {
  const AboutDearoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo.shade900,
            child: const Center(
              child: Text(
                "OUR SERVICES",
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Add a valid image path
            fit: BoxFit.cover,
          ),
        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100), // Adjust spacing
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
