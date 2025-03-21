import 'package:allodoc/screens/login.dart';
import 'package:allodoc/screens/widgets/indicateur.dart';
import 'package:flutter/material.dart';
import 'splash4.dart'; 
import '../widgets/custom_button.dart'; 

class Splash3 extends StatelessWidget {
  const Splash3({super.key});

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
                'assets/splashs/splash3.png',
                width: double.infinity, 
                fit: BoxFit.cover, 
                height: 450,
              ),
              const SizedBox(height: 20),
              const Text(
                'Connect with Specialists',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              DotIndicator(currentIndex: 1, totalDots: 3), 
              const SizedBox(height: 20),
              CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Splash4()),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}