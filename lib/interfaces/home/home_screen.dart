import 'package:flutter/material.dart';
import 'lease_home.dart';
import 'insuarance_home.dart';
import 'gold_loan_home.dart';
import 'investment_home.dart';
import 'dearo_page.dart'; 
import '../../shape/custom_shape.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {"title": "Lease", "image": "assets/lease_car.jpg", "width": 160.0, "height": 130.0, "icon": Icons.directions_car},
    {"title": "Investment", "image": "assets/investment.jpg", "width": 150.0, "height": 130.0, "icon": Icons.trending_up},
    {"title": "Insurance", "image": "assets/insuarance.png", "width": 120.0, "height": 130.0, "icon": Icons.security},
    {"title": "Gold Loan", "image": "assets/gold_loan.jpg", "width": 170.0, "height": 130.0, "icon": Icons.monetization_on},
  ];

  HomeScreen({super.key});

  void handleButtonPress(BuildContext context, String service) {
    switch (service) {
      case "Lease":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaseHome()));
        break;
      case "Investment":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InvestmentHome()));
        break;
      case "Insurance":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const InsuaranceHome()));
        break;
      case "Gold Loan":
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GoldLoanHome()));
        break;
    }
  }

  void navigateToDearoPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DearoPage()));
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
                    "     OUR SERVICES      ",
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () => navigateToDearoPage(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.asset(
                      "assets/dearo_logo.webp", // Ensure this image is in your assets folder 
                       
                      height: 40,
                      width: 40,
                    ),
                  ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(services[index]["icon"], color: Colors.blue[900]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                services[index]["title"]!,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
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