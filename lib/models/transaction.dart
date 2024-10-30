class Transaction {
  final String serviceName;
  final double amount;
  final DateTime date;

  Transaction({
    required this.serviceName,
    required this.amount,
    required this.date,
  });
}
