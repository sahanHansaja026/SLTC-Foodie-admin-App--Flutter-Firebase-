import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sltc/services/auth/auth_service.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  // Function to fetch user orders from Firestore
  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final AuthService authService = AuthService();
    final String userEmail = authService.getUserEmail();

    // Fetch orders from Firestore where user_email matches the current user's email
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('user_email', isEqualTo: userEmail)
        .get();

    // Extract order data from the query snapshot
    final List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Add document ID for reference
      return data;
    }).toList();

    return orders;
  }

  // Function to cancel an order
  Future<void> _cancelOrder(String orderId) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': 'canceled',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final isCanceled = order['status'] == 'canceled';

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: SizedBox(
                      width: 100,
                      child: order['image_url'] != null
                          ? Image.network(
                              order['image_url'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.error,
                                size: 100,
                                color: Colors.red,
                              ),
                            )
                          : const Icon(Icons.image, size: 100),
                    ),
                    title: Text(order['food_name'] ?? 'No name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: LKR ${order['total_price'].toStringAsFixed(2)}'),
                        Text('Date: ${order['date']}'),
                        Text('Time: ${order['time']}'),
                        Text(
                          isCanceled ? 'Status: Canceled' : 'Status: Available',
                          style: TextStyle(
                            color: isCanceled ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: isCanceled
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () async {
                              // Confirm cancellation
                              final bool confirmCancel = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Cancel Order'),
                                    content: const Text('Are you sure you want to cancel this order?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmCancel) {
                                // Call the function to cancel the order
                                await _cancelOrder(order['id']);
                                
                                // Show a confirmation message
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Order canceled successfully!')),
                                );
                                
                                // Refresh the UI after canceling the order
                                // ignore: invalid_use_of_protected_member
                                (context as Element).reassemble();
                              }
                            },
                          ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
