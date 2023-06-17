import 'package:flutter/material.dart';
import 'package:my_personal_expenses_app/pages/expenses_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listPages = const [
    ExpensesPage(),
    Text('Programar'),
    Text('Profile'),
  ];

  var _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
        ],
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
