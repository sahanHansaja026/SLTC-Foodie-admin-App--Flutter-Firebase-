import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final String foodName;
  final String status;
  final String date;
  final String time;
  final String imageUrl;
  final double totalPrice;
  final String userEmail;
  final String orderId;

  const OrderDetails({
    Key? key,
    required this.foodName,
    required this.status,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.totalPrice,
    required this.userEmail,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodyText1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red, size: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Food Name: $foodName',
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: $orderId',
            ),
            const SizedBox(height: 8),
            Text(
              'Status: $status',
              style: TextStyle(
                color: status == 'canceled' ? Colors.red : Colors.green,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: $date',
            ),
            const SizedBox(height: 8),
            Text(
              'Time: $time',
            ),
            const SizedBox(height: 8),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',

            ),
            const SizedBox(height: 8),
            Text(
              'User Email: $userEmail',
            ),
          ],
        ),
      ),
    );
  }
}
