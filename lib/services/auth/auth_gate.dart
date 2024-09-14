import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sltc/pages/home_page.dart'; // Updated import to HomePage
import 'package:sltc/services/auth/login_or_register.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _forceSignOut();
  }

  Future<void> _forceSignOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Force user to log out on app startup
      setState(() {
        _isLoading = false; // Once signed out, stop the loading indicator
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error signing out: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show loading indicator while logging out
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      // Show error message if there was an issue signing out
      return Scaffold(
        body: Center(
          child: Text(_errorMessage!),
        ),
      );
    }

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check if user is logged in
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage(); // User is logged in, navigate to HomePage
          } else {
            return const LoginOrRegister(); // User is not logged in, show login/register screen
          }
        },
      ),
    );
  }
}
