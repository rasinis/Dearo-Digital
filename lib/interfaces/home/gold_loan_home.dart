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
      home: GoldLoanHome(),
    );
  }
}

class GoldLoanHome extends StatefulWidget {
  const GoldLoanHome({super.key});

  @override
  _GoldLoanHomeState createState() => _GoldLoanHomeState();
}

class _GoldLoanHomeState extends State<GoldLoanHome> {
  Map<String, bool> visibilityMap = {
    'Loan Against Gold': false,
    'Collateral': false,
    'Gold Purity Range': false,
    'Loan Type': false,

  };

  Map<String, String> descriptions = {
    'Loan Against Gold': "A Secured Loan",
    'Collateral': "Borrower pledges their gold articles.",
    'Gold Purity Range': "18 karats to 24 karats.",
    'Loan Type': "Offered by lenders against gold as security.",
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
            Image.asset('assets/gold_loan_home.jpg', height: 300, width:300,),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "CASH IN CLUTTER OUT ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(height: 16),
            buildExpandableTile('Loan Against Gold'),
            buildExpandableTile('Collateral'),
            buildExpandableTile('Gold Purity Range'),
            buildExpandableTile('Loan Type'),

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
