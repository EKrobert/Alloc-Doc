import 'package:allodoc/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:allodoc/screens/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logos/logo.jpeg', 
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hi, Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hope you are doing fine',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Champ email avec icône
              TextFormField(
                style: const TextStyle(color: Colors.black), 
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                      Icon(Icons.email, color: Colors.black), 
                  border: OutlineInputBorder(),
                  hintText: 'Your Email',
                  hintStyle:
                      TextStyle(color: Colors.grey), 
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
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(color: Colors.grey), 
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromRGBO(22, 42, 58, 1),
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), 
                  minimumSize: const Size(double.infinity,50), 
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25), 
                  ),
                ),
                child: const Text('Sign In'),
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

              // Bouton "Sign in with Google"
              ElevatedButton(
                onPressed: () {
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
                      'assets/logos/google.png', 
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text('Sign in with Google'),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Bouton "Sign in with Facebook"
              ElevatedButton(
                onPressed: () {
                  
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
                      'assets/logos/facebook.png', 
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text('Sign in with Facebook'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Forgot password
              TextButton(
                onPressed: () {
                  
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue),
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: 10),

              // Lien "sign up"
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black), 
                  children: [
                    const TextSpan(text: "Don't have any account yet? "),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
