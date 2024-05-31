import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/noticias/screens/Lista_noticias.dart';
import 'package:flutter_application_1/utils/services/firebase_auth.dart';
import 'package:get/get.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
  
}

class _LoginAppState extends State<LoginApp> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String pass = _passwordController.text.trim();

    try {
      final user = await _auth.signInWithEmailAndPassword(email, pass);

      if (user != null) {
        print('User signed in successfully');
        Get.to(const ListNoticias());
      } else {
        setState(() {
          _errorMessage = 'The user/password is incorrect';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = 'Authentication failed. Please try again later.';
        }
      }

      setState(() {
        _errorMessage = errorMessage;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          duration: const Duration(seconds: 3),
        ),
      );

      print('Sign in error: $e'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.lock, 
                size: 80.0,
                color: Colors.blue,
              ),
              const SizedBox(height: 16.0),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  signIn(context);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}