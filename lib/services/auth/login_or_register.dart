import 'package:flutter/material.dart';
import 'package:sltc/pages/login_page.dart';
import 'package:sltc/pages/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display the appropriate page based on the value of showLoginPage
    return Scaffold(
      appBar: AppBar(
        title: Text(showLoginPage ? 'Login' : 'Register'),
      ),
      body: showLoginPage
          ? LoginPage(onTap: togglePages)
          : RegisterPage(onTap: togglePages),
    );
  }
}
