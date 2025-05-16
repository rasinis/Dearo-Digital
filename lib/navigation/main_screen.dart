import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../providers/bottom_nav_provider.dart';
import '../interfaces/home/home_screen.dart';
import '../interfaces/inquiry/inquiry_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> pages = [
    HomeScreen(),
    InquiryScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: pages[provider.selectedIndex], // Display selected page
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                gap: 8,
                backgroundColor: Colors.indigo.shade900,
                tabBackgroundColor: const Color(0xFFDEDFF2),
                selectedIndex: provider.selectedIndex,
                onTabChange: (index) => provider.changeIndex(index),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    iconActiveColor: Colors.cyanAccent,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.announcement_outlined,
                    iconColor: Colors.white,
                    iconActiveColor: Colors.cyanAccent,
                    text: 'Inquiry',
                  ),
                 
                  GButton(
                    icon: Icons.account_circle_sharp,
                    iconColor: Colors.white,
                    iconActiveColor: Colors.cyanAccent,
                    text: 'Profile',
                  ),
                   GButton(
                    icon: Icons.info_outline_sharp,
                    iconColor: Colors.white,
                    iconActiveColor: Colors.cyanAccent,
                    text: 'About',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
