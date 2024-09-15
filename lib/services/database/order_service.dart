// lib/services/order_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrdersStreamByStatus(String status) {
    return _firestore
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots();
  }
}
