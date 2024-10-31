import 'package:burgan_bill/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  // double get totalexpenses2 =>
  //     transactions.map((t) => t.amount).fold(0, (sum, c) => sum + c);

  double get totalexpenses {
    double sum = 0;
    for (var i = 0; i < transactions.length; i++) {
      sum += transactions[i].amount;
    }
    return sum;
  }

  void addTransaction(String serviceName, double amount) {
    _transactions.add(Transaction(
      serviceName: serviceName,
      amount: amount,
      date: DateTime.now(),
    ));
    notifyListeners();
  }
}
