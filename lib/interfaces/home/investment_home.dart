// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InvestmentHome(),
    );
  }
}

class InvestmentHome extends StatefulWidget {
  const InvestmentHome({super.key});

  @override
  _InvestmentHomeState createState() => _InvestmentHomeState();
}

class _InvestmentHomeState extends State<InvestmentHome> {
  Map<String, bool> visibilityMap = {
    'Investment Option': false,
    'Tenure Options': false,  // Changed to match descriptions key
    'Profits & Interest Rates': false,
  };

  Map<String, String> descriptions = {
    'Investment Option': "Provides financial rewards through profits and interest rates.",
    'Tenure Options': "Ranges from 6 months to 60 months. Flexible duration to suit different investment preferences.",
    'Profits & Interest Rates': "Vary based on the investment tenure.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/investment_home.jpg', height: 300, width: 300),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "INVEST TODAY FOR A BETTER TOMORROW",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(height: 16),
            buildExpandableTile('Investment Option'),
            buildExpandableTile('Tenure Options'),  // Changed to match descriptions key
            buildExpandableTile('Profits & Interest Rates'),
          ],
        ),
      ),
    );
  }

  Widget buildExpandableTile(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          trailing: IconButton(
            icon: Icon(visibilityMap[title]! ? Icons.remove : Icons.add),
            onPressed: () {
              setState(() {
                visibilityMap[title] = !visibilityMap[title]!;
              });
            },
          ),
        ),
        Visibility(
          visible: visibilityMap[title]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              descriptions[title] ?? 'Description not available',  // Added fallback
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}