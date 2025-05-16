

// ignore_for_file: prefer_const_constructors

import 'package:dearo_app/interfaces/inquiry/lease_inquiry.dart';
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
      home: StartLease(
        inquiryId: 1, // Replace with the actual inquiry ID
        inquiryType: 'Lease', // Replace with the actual inquiry type
      ),
    );
  }
}

class StartLease extends StatelessWidget {
  const StartLease({super.key, required int inquiryId, required String inquiryType});

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
              'assets/start_inquiry.jpg', 
              height: 300,

            ),
            const SizedBox(height: 30),
            const Text(
              'Start Lease Inquiry',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
                              builder: (context) => LeaseFormScreen(
                                bearerToken: 'sampleToken', 
                                inquiryId: 1,
                                inquiryType: 'Lease', 
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
