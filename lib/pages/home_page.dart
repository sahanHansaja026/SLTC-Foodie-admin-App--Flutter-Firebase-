import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sltc/components/my_drawer.dart'; // Importing the drawer component
import 'package:sltc/services/database/order_service.dart';
import 'order_details.dart'; // Import the OrderDetails page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OrderService _orderService = OrderService();
  Stream<QuerySnapshot>? orderStream;

  @override
  void initState() {
    super.initState();
    loadOrderDetails();
  }

  void loadOrderDetails() {
    setState(() {
      orderStream = _orderService.getOrdersStream();
    });
  }

  Widget allOrderDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: orderStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Orders Available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetails(
                      foodName: ds['food_name'],
                      status: ds['status'],
                      date: ds['date'],
                      time: ds['time'],
                      imageUrl: ds['image_url'],
                      totalPrice: ds['total_price'],
                      userEmail: ds['user_email'],
                      orderId: ds['order_id'],
                    ),
                  ),
                );
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds['food_name'] ?? 'No Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 26.0,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Status: ${ds['status'] ?? 'No Status'}",
                              style: TextStyle(
                                color: ds['status'] == 'canceled'
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Date: ${ds['date']} at ${ds['time']}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          ds['image_url'] ?? '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SLTC Orders"),
        backgroundColor: Colors.teal,
      ),
      drawer: const MyDrawer(), // Adding the drawer here
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allOrderDetails()),
          ],
        ),
      ),
    );
  }
}
