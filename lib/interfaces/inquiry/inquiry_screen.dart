// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:dearo_app/interfaces/inquiry/gold_loan_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/insuarance_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/investment_inquiry_profile.dart';
import 'package:dearo_app/interfaces/inquiry/lease_inquiry_profile.dart';
import 'package:flutter/material.dart';
import 'package:dearo_app/models/shared_preference_manager.dart';
import '../../shape/custom_shape.dart';
import 'my_inquiry.dart';

class InquiryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      "title": "Lease",
      "image": "assets/lease_car.jpg",
      "width": 160.0,
      "height": 130.0,
      "icon": Icons.directions_car,
    },
    {
      "title": "Investment",
      "image": "assets/investment.jpg",
      "width": 150.0,
      "height": 130.0,
      "icon": Icons.trending_up,
    },
    {
      "title": "Insurance",
      "image": "assets/insuarance.png",
      "width": 120.0,
      "height": 130.0,
      "icon": Icons.security,
    },
    {
      "title": "Gold Loan",
      "image": "assets/gold_loan.jpg",
      "width": 170.0,
      "height": 130.0,
      "icon": Icons.monetization_on,
    },
  ];

  InquiryScreen({super.key});

  void handleButtonPress(BuildContext context, String service) async {
    // Retrieve the bearer token from SharedPreferences
    String? bearerToken = await SharedPreferenceManager.getBearerToken();

    if (bearerToken == null) {
      print("Bearer token is null. User not authenticated.");
      return;
    }

    switch (service) {
      case "Lease":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => LeaseInquiryProForm(
                  bearerToken: bearerToken,
                  isInquiryPending: true,
                  inquiryType: "LEASE",
                ),
          ),
        );
        break;
      case "Investment":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => InvestmentInquiryProForm(
                  bearerToken: bearerToken,
                  isInquiryPending: true,
                  inquiryType: "FD",
                ),
          ),
        );
        break;
      case "Insurance":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => InsuaranceInquiryProForm(
                  bearerToken: bearerToken,
                  isInquiryPending: true,
                  inquiryType: "INSURANCE",
                ),
          ),
        );
        break;
      case "Gold Loan":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => GoldLoanInquiryProForm(
                  bearerToken: bearerToken,
                  isInquiryPending: true,
                  inquiryType: "GOLD_LOAN",
                ),
          ),
        );
        break;
    }
  }

  void handleIconPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyInquiry()),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "         INQUIRY            ",
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => handleIconPress(context),
                ),
              ],
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    onPressed:
                        () => handleButtonPress(
                          context,
                          services[index]["title"]!,
                        ),
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
                            Icon(
                              services[index]["icon"],
                              color: Colors.blue[900],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              services[index]["title"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
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
