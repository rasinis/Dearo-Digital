// ignore_for_file: prefer_const_constructors

import 'package:dearo_app/interfaces/inquiry/upload_vehicle_proof.dart';
import 'package:dearo_app/models/data/inquiry_record.dart';
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
      home: UploadVehicleImageScreen(),
    );
  }
}

class UploadVehicleImageScreen extends StatelessWidget {
  const UploadVehicleImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a sample InquiryRecord object
    InquiryRecord inquiryRecord = InquiryRecord(
      id: 1,
      customer_id: 101,
      inquiry_type: 'LEASE',
      inquiry_status: 'PENDING',
      reference_inquiry_id: 10,
      created_at: DateTime.now(),
      updated_at: DateTime.now(),
      inquiry_info: null, // Replace with actual inquiry info if available
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/upload_vehicle_image2.jpg',
              height: 300,
            ),
            const SizedBox(height: 30),
            const Text(
              'Proceed to Upload Vehicle Images',
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
                  // Navigate to VehiclePhotoProofScreen with InquiryRecord
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehiclePhotoProofScreen(
                        bearerToken: 'sampleToken',
                        inquiryId: inquiryRecord.id,
                        inquiryRecord: inquiryRecord,
                        inquiryType: inquiryRecord.inquiry_type, 
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