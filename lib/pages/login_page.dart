import 'package:flutter/material.dart';
import 'package:sltc/components/my_button.dart';
import 'package:sltc/components/my_textfield.dart';
import 'package:sltc/services/auth/auth_service.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  // Forgot Password method (placeholder for actual implementation)
  void forgotPw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Forgot Password"),
        content: const Text("Password recovery is not implemented yet."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Icon(
            Icons.lock_open_rounded,
            size: 72,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          const SizedBox(height: 10),

          // App slogan
          Text(
            "MARK Technologies",
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 10),

          // Email field
          MyTextfield(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),
          const SizedBox(height: 10),

          // Password textfield
          MyTextfield(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 10),

          // Sign in button
          MyButton(
            text: "Sign in",
            onTap: login,
          ),
          const SizedBox(height: 20),

          // Go to the registration page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
