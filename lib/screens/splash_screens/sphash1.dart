import 'package:flutter/material.dart';
import 'splash2.dart'; 

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash1.jpg'), 
            const SizedBox(height: 20),
            const Text(
              'Bienvenue sur Allo Doc',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Splash2()),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}