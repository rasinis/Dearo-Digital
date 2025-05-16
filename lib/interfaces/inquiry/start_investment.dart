

// ignore_for_file: prefer_const_constructors

import 'package:dearo_app/interfaces/inquiry/investment_inquiry.dart';
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
      home: StartInvestment(inquiryId: 0, inquiryType: 'FD'),
    );
  }
}

class StartInvestment extends StatefulWidget {
  const StartInvestment({
    super.key,
    required this.inquiryId,
    required this.inquiryType,
  });

  final int inquiryId;
  final String inquiryType;

  @override
  State<StartInvestment> createState() => _StartInvestmentState();
}

class _StartInvestmentState extends State<StartInvestment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/start_inquiry.jpg', height: 300),
            const SizedBox(height: 30),
            const Text(
              'Start Investment Inquiry',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => InvestmentForm(
                            bearerToken: 'sampleToken',
                            currentState:
                                'PROFILE_COMPLETED', 
                            inquiryId: 0,
                            inquiryType: 'FD',
                            currentStte: 'ACTIVE', 
                          ),
                    ),
                  );
                },

                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
