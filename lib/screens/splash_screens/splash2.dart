import 'package:flutter/material.dart';
import 'splash3.dart'; // Prochain écran
import '../widgets/custom_button.dart'; // Bouton personnalisé

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Titre du deuxième écran',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description du deuxième écran',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            CustomButton(
              text: 'Suivant',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Splash3()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}