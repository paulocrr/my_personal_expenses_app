import 'package:flutter/material.dart';
import 'package:my_personal_expenses_app/pages/home_page.dart';
import 'package:my_personal_expenses_app/services/authentication_service.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SocialLoginButton(
            buttonType: SocialLoginButtonType.google,
            onPressed: () async {
              try {
                final authenticationService = AuthenticationService();
                await authenticationService.signInWithGoogle();

                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) {
                        return const HomePage();
                      },
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al autenticar'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
