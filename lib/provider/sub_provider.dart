import 'package:burgan_bill/Service/sub_service.dart';
import 'package:burgan_bill/models/subscription.dart';
import 'package:flutter/material.dart';

class SubProvider extends ChangeNotifier {
  List<Sub> subscriptions = [];

  Future<void> getSubscription() async {
    try {
      subscriptions = await SubService().subscribe();
      notifyListeners();
      print(subscriptions);
    } catch (e) {
      print("Failed to get subscriptions: $e");
    }
  }
}
