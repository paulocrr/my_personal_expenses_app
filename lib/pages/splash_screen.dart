import 'package:flutter/material.dart';
import 'package:my_personal_expenses_app/pages/home_page.dart';
import 'package:my_personal_expenses_app/pages/login_page.dart';
import 'package:my_personal_expenses_app/services/authentication_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthenticationStatus();
  }

  Future<void> checkAuthenticationStatus() async {
    final authenticationService = AuthenticationService();

    final isLoggedIn = await authenticationService.isLoggedIn();

    if (context.mounted) {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return const HomePage();
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return const LoginScreen();
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
