import 'package:dearo_app/interfaces/about_dearo/about_us.dart';
import 'package:dearo_app/interfaces/about_dearo/privacy_policy.dart';
import 'package:dearo_app/interfaces/about_dearo/terms_and_conditions.dart';
import 'package:flutter/material.dart';

class DearoPage extends StatelessWidget {
  const DearoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "DEARO INVESTMENT LIMITED",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            const SizedBox(height: 50.0),
            ListTile(
              title: const Text(
                'About Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const AboutUsPage()),
                );
              },
            ),
            const Divider(),

            // Privacy Policy Section
            ListTile(
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const PrivacyPolicyPage()),
                );
              },
            ),
            const Divider(),

            // Terms & Conditions Section
            ListTile(
              title: const Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const TermsAndConditionsPage()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}