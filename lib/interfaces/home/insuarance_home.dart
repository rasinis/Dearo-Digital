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
      home: InsuaranceHome(),
    );
  }
}

class InsuaranceHome extends StatefulWidget {
  const InsuaranceHome({super.key});

  @override
  _InsuaranceHomeState createState() => _InsuaranceHomeState();
}

class _InsuaranceHomeState extends State<InsuaranceHome> {
  Map<String, bool> visibilityMap = {
    'Dream Car Ownership': false,
    'Tailor-Made Solutions': false,
    'Vehicle Options': false,
    'Low Interest Rates': false,

  };

  Map<String, String> descriptions = {
    'Dream Car Ownership': "Everybody's aim is to own their dream car one day.",
    'Tailor-Made Solutions': "Dearo Investment Limited Hire Purchase offers fast, customized solutions.",
    'Vehicle Options': "Available for new, used, or pre-owned vehicles of your choice.",
    'Low Interest Rates': "Enjoy the lowest interest rates to enhance your investment.",
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
            Image.asset('assets/lease_home.jpg', height: 300, width:300,),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "YOUR INSUARANCE PARTNER",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(height: 16),
            buildExpandableTile('Dream Car Ownership'),
            buildExpandableTile('Tailor-Made Solutions'),
            buildExpandableTile('Vehicle Options'),
            buildExpandableTile('Low Interest Rates'),

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
              descriptions[title]!,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
