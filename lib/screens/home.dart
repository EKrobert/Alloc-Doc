import 'package:allodoc/home/home_screen.dart';
import 'package:allodoc/mapscreen.dart';
import 'package:allodoc/screens/booking/my_bokings.dart';
import 'package:allodoc/screens/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Par défaut, l'onglet "Home" est sélectionné

  // Liste des pages correspondant aux onglets
  final List<Widget> _pages = [
    HomePage(),
    MapScreen(),
    BookingPage(),
    ProfileScreen()
  ];

  // Fonction pour gérer le changement d'onglet
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Affiche la page correspondante
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType
            .fixed, // Assure que les icônes ne bougent pas
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_sharp), 
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
