import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // To format date and time

class PaymentService {
  // Function to save payment details to Firestore
  Future<void> savePaymentDetails({
    required String userEmail,
    required String foodName,
    required double totalPrice,
    required String imageUrl, // Add ImageURL parameter
  }) async {
    // Get current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    // Create a reference for the new document
    DocumentReference docRef = FirebaseFirestore.instance.collection('orders').doc();

    // Save data to Firestore 'orders' collection
    await docRef.set({
      'order_id': docRef.id, // Store the document ID as order_id
      'user_email': userEmail,
      'food_name': foodName,
      'total_price': totalPrice,
      'date': formattedDate,
      'time': formattedTime,
      'image_url': imageUrl, // Add ImageURL field
    });
  }
}
