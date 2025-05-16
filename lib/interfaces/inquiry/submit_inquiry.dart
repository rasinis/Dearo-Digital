

// ignore_for_file: avoid_print, library_private_types_in_public_api

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
      home: SubmitInquiryScreen(bearerToken: 'sampleToken', inquiryId: 0),
    );
  }
}

class SubmitInquiryScreen extends StatefulWidget {
  final String bearerToken;
  final int inquiryId;

  const SubmitInquiryScreen({
    Key? key,
    required this.bearerToken,
    required this.inquiryId,
  }) : super(key: key);

  @override
  _SubmitInquiryScreenState createState() => _SubmitInquiryScreenState();
}

class _SubmitInquiryScreenState extends State<SubmitInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/inquiry_process.jpg', // Replace with your actual image asset
              height: 200,
            ),
            const SizedBox(height: 30),
            const Text(
              'Submit Your Inquiry For Approval',
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
                  // Handle Submit Button Press
                  print('Bearer Token: ${widget.bearerToken}');
                  print('Inquiry ID: ${widget.inquiryId}');
                  // Add your submission logic here
                },
                child: const Text(
                  'Submit',
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
