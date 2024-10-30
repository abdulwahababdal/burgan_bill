import 'package:burgan_bill/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(String serviceName, double amount) {
    _transactions.add(Transaction(
      serviceName: serviceName,
      amount: amount,
      date: DateTime.now(),
    ));
    notifyListeners();
  }
}
