import 'package:flutter/material.dart';
import 'package:allodoc/screens/home.dart';
import 'package:allodoc/screens/login.dart'; // Importez votre écran de login

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Permet le défilement pour éviter le débordement
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo personnalisé
              Image.asset(
                'assets/logos/logo.jpeg', // Remplacez par le chemin de votre logo
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign up to get started',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Champ nom avec icône
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon:
                      Icon(Icons.person, color: Colors.black),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your full name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // Champ email avec icône
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                      Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(),
                  hintText: 'Your Email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // Champ mot de passe avec icône
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon:
                      Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(),
                  hintText: 'Create Password',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              // Champ confirmation mot de passe avec icône
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon:
                      Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // Logique d'inscription
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(22, 42, 58, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),

              // Ligne "or"
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Bouton "Sign up with Google"
              ElevatedButton(
                onPressed: () {
                  // Logique pour Google
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text('Sign up with Google'),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Bouton "Sign up with Facebook"
              ElevatedButton(
                onPressed: () {
                  // Logique pour Facebook
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/facebook.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text('Sign up with Facebook'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Lien pour se connecter
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: "Already have an account? "),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}