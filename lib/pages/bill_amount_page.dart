import 'package:burgan_bill/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'payment_success_page.dart';
import 'package:provider/provider.dart';

class BillAmountPage extends StatelessWidget {
  final String serviceName;
  final String logoPath;
  final double amountDue;

  const BillAmountPage({
    key,
    required this.serviceName,
    required this.logoPath,
    required this.amountDue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${serviceName} Bill Amount'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top
            Center(
              child: Image.asset(
                logoPath,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Amount Due
            Text(
              'Total Amount Due: ${amountDue.toStringAsFixed(2)} KWD',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Pay Button
            ElevatedButton(
              onPressed: () {
                context
                    .read<TransactionProvider>()
                    .addTransaction(serviceName, amountDue);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessPage(),
                  ),
                );
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
