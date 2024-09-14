import 'package:flutter/material.dart';
import 'package:sltc/components/my_button.dart';
import 'package:sltc/components/my_textfield.dart';
import 'package:sltc/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  // Register method
  void register() async {
    // Get auth services
    final authService = AuthService();

    // Check if passwords match
    if (passwordController.text == confirmpasswordController.text) {
      try {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
        // Navigate to home page or show success message
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Error'),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match"),
        ),
      );
    }
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

          const SizedBox(height: 5),

          // App slogan
          Text(
            "Let's create an account",
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          const SizedBox(height: 5),

          // Email field
          MyTextfield(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
          ),

          const SizedBox(height: 5),

          // Password textfield
          MyTextfield(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),

          const SizedBox(height: 5),

          // Confirm Password textfield
          MyTextfield(
            controller: confirmpasswordController,
            hintText: "Confirm Password",
            obscureText: true,
          ),

          const SizedBox(height: 10),

          // Sign up button
          MyButton(
            text: "Sign up",
            onTap: register,
          ),

          const SizedBox(height: 10),

          // Go to the login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Log in now",
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
