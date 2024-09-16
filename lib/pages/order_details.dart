import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final String foodName;
  final String status;
  final String date;
  final String time;
  final String imageUrl;
  final double totalPrice;
  final String userEmail;
  final String orderId;
  final int quantity;

  const OrderDetails({
    super.key,
    required this.foodName,
    required this.status,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.totalPrice,
    required this.userEmail,
    required this.quantity,
    required this.orderId,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String _currentStatus = ''; // Holds the current status

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status; // Initialize with the current order status
  }

  // Function to update the order status in Firestore
  void _updateOrderStatus(String newStatus) async {
    try {
      // Update the status in Firestore for the given order ID
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .update({'status': newStatus});

      // Update the state
      setState(() {
        _currentStatus = newStatus;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order status updated to $newStatus')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
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
                widget.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.red, size: 200),
              ),
            ),
            const SizedBox(height: 16),
            Text('Food Name: ${widget.foodName}'),
            const SizedBox(height: 8),
            Text('Order ID: ${widget.orderId}'),
            const SizedBox(height: 8),
            Text('Date: ${widget.date}'),
            const SizedBox(height: 8),
            Text('Time: ${widget.time}'),
            const SizedBox(height: 8),
            Text('Total Price: \$${widget.totalPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('quentity: ${widget.quantity}'),
            const SizedBox(height: 8),
            Text('User Email: ${widget.userEmail}'),

            const SizedBox(height: 16),
            const Text(
              'Update Order Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            // Radio Button Group for Order Status
            ListTile(
              title: const Text('Processing'),
              leading: Radio<String>(
                value: 'processing',
                groupValue: _currentStatus,
                onChanged: (String? value) {
                  if (value != null) _updateOrderStatus(value);
                },
              ),
            ),
            ListTile(
              title: const Text('Ready to Deliver'),
              leading: Radio<String>(
                value: 'ready to deliver',
                groupValue: _currentStatus,
                onChanged: (String? value) {
                  if (value != null) _updateOrderStatus(value);
                },
              ),
            ),
            ListTile(
              title: const Text('Delivered'),
              leading: Radio<String>(
                value: 'delivered',
                groupValue: _currentStatus,
                onChanged: (String? value) {
                  if (value != null) _updateOrderStatus(value);
                },
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'Current Status: $_currentStatus',
              style: TextStyle(
                color: _currentStatus == 'canceled' ? Colors.red : Colors.green,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
