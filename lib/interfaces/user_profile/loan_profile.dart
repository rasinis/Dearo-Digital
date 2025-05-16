import 'package:flutter/material.dart';

class LoanProfile extends StatelessWidget {
  const LoanProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lease ", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: const Center(
        child: Text(
          "Welcome to Lease Profile Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
