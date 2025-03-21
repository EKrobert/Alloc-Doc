import 'package:allodoc/screens/login.dart';
import 'package:allodoc/screens/widgets/indicateur.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart'; 

class Splash4 extends StatelessWidget {
  const Splash4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splashs/splash4.png',
                width: double.infinity, 
                fit: BoxFit.cover, 
                height: 450,
              ),
              const SizedBox(height: 20),
              const Text(
                'Thousands of Online Specialists',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              DotIndicator(currentIndex: 2, totalDots: 3), 
              const SizedBox(height: 20),
              CustomButton(
                text: 'Commencer',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}