import 'package:flutter/material.dart';

class MyInquiry extends StatelessWidget {
  const MyInquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Inquiry ", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: const Center(
        child: Text(
          "Welcome to My Inquiry Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
