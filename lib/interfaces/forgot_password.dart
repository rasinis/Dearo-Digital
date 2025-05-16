import 'package:flutter/material.dart';
import 'verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {return Scaffold(
       body: 
       Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
                 color: Colors.white,
                image: DecorationImage(
                image: AssetImage(
                    ''), 
                     fit: BoxFit.cover,
        
          ),
        ),
    //return Scaffold(
      //backgroundColor: Colors.white,
      //body: Padding(
       // padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/forgotpassword.jpg', 
              height: 150,
            ),
            const SizedBox(height: 25),
            Text(
              "FORGOT PASSWORD",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900, 
              ),
            ),
            const SizedBox(height: 70),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Phone number",
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFDEDFF2), // Light Purple Background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  VerificationScreen()),
                          );
                  
                },
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: 
                  const  Color(0xFF070E71),
                   //width: 50,
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
