import 'package:flutter/material.dart';
import 'loan_profile.dart';
//import 'insuarance_profile.dart';
//import 'gold_loan_profile.dart';
import 'investment_profile.dart';

import '../../shape/custom_shape.dart';
import 'user_details.dart';

class UserProfileScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {"title": "Loan", "image": "assets/loan.jpg", "width": 160.0, "height": 130.0, "icon": Icons.directions_car},
    {"title": "Investment", "image": "assets/investment.jpg", "width": 150.0, "height": 130.0, "icon": Icons.trending_up},
   
  ];

  UserProfileScreen({super.key});

  void handleButtonPress(BuildContext context, String service) {
    switch (service) {
      case "Loan":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoanProfile()),
        );
        break;
      case "Investment":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InvestmentProfile()),
        );
        break;
      
    }
  }

  void handleIconPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo.shade900,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "    MY ACCOUNT       ",
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined, color: Colors.white, size: 36),
                    onPressed: () => handleIconPress(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                    ),
                    onPressed: () => handleButtonPress(context, services[index]["title"]!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          services[index]["image"]!,
                          height: services[index]["height"],
                          width: services[index]["width"],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(services[index]["icon"], color: Colors.blue[900]),
                            const SizedBox(width: 4),
                            Text(
                              services[index]["title"]!,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}