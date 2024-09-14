// lib/services/order_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrdersStream() {
    return _db.collection('orders').snapshots();
  }
}
