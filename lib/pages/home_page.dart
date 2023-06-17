import 'package:flutter/material.dart';
import 'package:my_personal_expenses_app/pages/login_page.dart';
import 'package:my_personal_expenses_app/services/authentication_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final authenticationService = AuthenticationService();
            await authenticationService.googleLogOut();
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) {
                    return const LoginScreen();
                  },
                ),
              );
            }
          },
          child: const Text('Log out'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'Gastos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Programar Gasto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ]),
    );
  }
}
