//import 'package:dearo_app/interfaces/dearo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/bottom_nav_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'interfaces/home/home_screen.dart';
import 'interfaces/inquiry/inquiry_screen.dart';
import 'interfaces/dearo_screen.dart';
import 'interfaces/user_profile/user_profile.dart';


class MainScreen extends StatelessWidget {
  final List<Widget> pages = [
    HomeScreen(),
    InquiryScreen(),
    UserProfileScreen(),
    const AboutDearoScreen(),
    
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: pages[provider.selectedIndex],
          bottomNavigationBar: GNav(
            gap: 8,
            backgroundColor: Colors.indigo.shade900,
            tabBackgroundColor: const Color(0xFFDEDFF2),
            selectedIndex: provider.selectedIndex,  
            onTabChange: (index) => provider.changeIndex(index),  
            tabs: const [
              GButton(
                icon: Icons.home,
                iconColor: Colors.white,
                iconActiveColor: Color(0xFF1A237E), // Equivalent to indigo.shade900
                text: 'Home',
              ),
              GButton(
                icon: Icons.announcement_outlined,
                iconColor: Colors.white,
                iconActiveColor: Color(0xFF1A237E),
                text: 'Inquiry',
              ),
              
              GButton(
                icon: Icons.account_circle_sharp,
                iconColor: Colors.white,
                iconActiveColor: Color(0xFF1A237E),
                text: 'User profile',
              ),
              GButton(
                icon: Icons.info_outline_sharp,
                iconColor: Colors.white,
                iconActiveColor: Color(0xFF1A237E),
                text: 'About Dearo',
              ),

            ],
          ),
        );
      },
    );
  }
}
