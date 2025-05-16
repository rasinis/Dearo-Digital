//import 'package:dearo_app/interfaces/forgot_password.dart';
//import 'package:dearo_app/interfaces/upload_vehicle_proof.dart';
import 'package:dearo_app/interfaces/inquiry/guarantor1_form.dart';
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
      home: Guarantor1AddScreen(),
    );
  }
}

class Guarantor1AddScreen extends StatelessWidget {
  const Guarantor1AddScreen({super.key});

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
              'assets/guarantor details.jpg', 
              height: 300,

            ),
            const SizedBox(height: 30),
            const Text(
              'Procced to Add Guarantor 1 Details ',
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
                            MaterialPageRoute(builder: (context) =>  const Guarantor1Form(bearerToken: 'sampleToken', // Replace with actual token
                  inquiryId: 1, 
                  inquiryType: 'LEASE', 
                  isFirst: true,)),
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
