//import 'package:dearo_app/interfaces/forgot_password.dart';
//import 'package:dearo_app/interfaces/in_vehicle_image_form.dart';
// ignore_for_file: prefer_const_constructors

import 'package:dearo_app/interfaces/inquiry/insuarance_inquiry.dart';
//import 'package:dearo_app/interfaces/investment_inquiry_profile.dart';
//import 'package:dearo_app/interfaces/lease_inquiry.dart';
//import 'package:dearo_app/interfaces/upload_vehicle_proof.dart';
import 'package:flutter/material.dart';


void mfain() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartInsuarance(),
    );
  }
}

class StartInsuarance extends StatelessWidget {
  const StartInsuarance({super.key});

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
              'Start Insuarance Inquiry',
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
                            MaterialPageRoute(builder: (context) => InsuaranceFormScreen(
                              bearerToken: 'sampleToken', 
                              inquiryId: 3, 
                              inquiryType: 'FD',
                            )),
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
