import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Name ", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: const Center(
        child: Text(
          "Welcome to My Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
