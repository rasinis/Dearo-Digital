import 'package:flutter/material.dart';

void main() {
  runApp(const AboutUsPage());
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                'ABOUT US',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 200),
              const Text(
                'Dearo Investment Limited Company duly incorporated in the Democratic Socialist Republic of Sri Lanka and registered under the Companies Act no 07 of 2007 public limited company. Dearo Investment Limited provides financial services and digital financial solutions in Sri Lanka, developing the SME and MSME sectors. Dearo Investment Limited subsidiaries have strategically diversified into key economic growth sectors across financial services, leisure, agriculture and plantations, construction and real estate, manufacturing and trading, technology, research and innovation, and strategic investments.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
