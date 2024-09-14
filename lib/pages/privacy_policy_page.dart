import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Effective Date: September 8, 2024\n\n"
                "App Name: SLTC Foodie\n"
                "Creator: Sahan Hansaja\n"
                "Presented by: MARK Technologies\n\n"
                "SLTC Foodie (\"the App\") is a mobile application developed using Flutter and Firebase for managing food items and orders in a restaurant. This Privacy Policy outlines how we collect, use, and protect your information when you use our services. By using the App, you agree to the terms of this Privacy Policy.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "1. Information We Collect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "- Personal Information: When you log in or register on the App, we collect your email address and any other information you provide during the registration process via Firebase Authentication.\n\n"
                "- Payment Information: For completing purchases, users enter Visa card details on the payment page. SLTC Foodie does not store payment information. All payment processing is handled by secure third-party services compliant with PCI standards.\n\n"
                "- Food Data: The App collects and stores data related to food items (name, price, offer, and image) that users add or manage within the App.\n\n"
                "- Device Information: We may collect information about your device, including your IP address, operating system, and app activity logs, to enhance your user experience.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "2. How We Use Your Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "- Authentication and Account Management: We use Firebase Authentication to log in and register users securely.\n\n"
                "- Order Processing: We collect and manage food item details, orders, and payment information to facilitate the proper functioning of the App.\n\n"
                "- Personalization: The App allows users to switch between dark mode and light mode in the settings page, enhancing user experience.\n\n"
                "- App Improvement: We analyze anonymized user activity to improve app performance, troubleshoot bugs, and add new features.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "3. Data Storage and Security",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "We use Firebase Cloud Firestore for secure data storage. All user data, including personal information and food details, is encrypted both in transit and at rest. We employ industry-standard security measures to protect your data from unauthorized access or disclosure.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "4. Third-Party Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "The App relies on third-party services, including Firebase for authentication and cloud storage. These services are GDPR-compliant and maintain high security standards for user data protection. SLTC Foodie does not share your data with any other third parties without your consent, except as required by law.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "5. Your Rights",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "As a user, you have the right to:\n"
                "- Access and update your personal information.\n"
                "- Request deletion of your account and personal data.\n"
                "- Opt-out of any communications or services offered through the App.\n\n"
                "To exercise any of these rights, please contact us via the support page within the App or reach out to MARK Technologies at [your contact email].",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "6. Data Retention",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "We retain your personal information as long as your account is active or as needed to provide you with the App's services. If you request to delete your account, we will permanently erase all associated personal data, except for any information we are required to keep by law.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "7. Changes to This Privacy Policy",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "We reserve the right to modify this Privacy Policy at any time. Any changes will be posted on this page, and the effective date will be updated accordingly. We encourage you to review this policy periodically to stay informed of how we are protecting your data.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "8. Contact Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "If you have any questions about this Privacy Policy, please contact us at:\n\n"
                "Sahan Hansaja\n"
                "MARK Technologies\n"
                "sahanhansaja026@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
