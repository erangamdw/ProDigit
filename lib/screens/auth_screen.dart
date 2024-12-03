import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _loginWithFirebase(BuildContext context) async {
    try {
      // Example anonymous sign-in with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      Get.off(() => const HomeScreen());
    } catch (e) {
      // Display error if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  void _continueAsGuest(BuildContext context) {
    // Navigate to HomeScreen directly as a guest
    Get.off(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Firebase Login Button
            ElevatedButton(
              onPressed: () => _loginWithFirebase(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                "Login with Firebase",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _continueAsGuest(context),
              child: const Text(
                "CONTINUE AS GUEST",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
