import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'interfaces/get_started.dart';
import 'interfaces/sign_in.dart';
import 'interfaces/sign_up.dart';
import 'interfaces/forgot_password.dart';
import 'interfaces/verification.dart';
import 'interfaces/reset_password.dart';
//import 'navigation/bottom_nav.dart'; 
import 'providers/bottom_nav_provider.dart';
import 'navigation/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/get_started',  // ✅ Start with Get Started screen
      routes: {
        '/get_started': (context) => const GetStartedScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),  
        '/forgot_password': (context) => const ForgotPasswordScreen(),  
        '/verification': (context) => VerificationScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/home': (context) => MainScreen(),  // ✅ Navigate here after login/signup
      },
    );
  }
}
