import 'package:flutter/material.dart';
import 'package:sltc/services/auth/auth_service.dart'; // Import your AuthService
import 'package:sltc/services/database/payment_service.dart'; // Import the PaymentService

class PaymentPage extends StatelessWidget {
  final double totalPrice;
  final String name;
  final String imageUrl;

  const PaymentPage({
    super.key,
    required this.totalPrice,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    String userEmail = authService.getUserEmail();

    final PaymentService paymentService = PaymentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 1, 2),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visa card image
            Center(
              child: Image.asset(
                'assets/images/visa_card.png',
                width: 550,
                height: 400,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Amount: LKR ${totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 30),

            const TextField(
              decoration: InputDecoration(
                labelText: "Card Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Expiration Date (MM/YY)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "CVV",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                try {
                  await paymentService.savePaymentDetails(
                    userEmail: userEmail,
                    foodName: name,
                    totalPrice: totalPrice,
                    imageUrl: imageUrl,
                  );

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment successful!')),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment failed: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 158, 31),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
