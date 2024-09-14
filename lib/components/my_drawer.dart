import 'package:flutter/material.dart';
import 'package:sltc/components/my_drawer_title.dart';
import 'package:sltc/pages/employee.dart';
import 'package:sltc/pages/settings_page.dart';
import 'package:sltc/pages/privacy_policy_page.dart'; // Import the new Privacy Policy page
import 'package:sltc/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Function to handle logout
  Future<void> _logout(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signOut();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/login'); // Navigate to the login page after sign out
    } catch (e) {
      // Handle error during sign out
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to log out: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list title
          MyDrawerTitle(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // settings list title
          MyDrawerTitle(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          // my orders list title
          MyDrawerTitle(
            text: "F O O D S",
            icon: Icons.add_box_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Employee()),
              );
            },
          ),

          // privacy policy list title
          MyDrawerTitle(
            text: "P R I V A C Y  P O L I C Y",
            icon: Icons.privacy_tip,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
              );
            },
          ),

          const Spacer(),
          // logout list title
          MyDrawerTitle(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () => _logout(context),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
