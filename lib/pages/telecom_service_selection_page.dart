// telecom_service_selection_page.dart
import 'package:flutter/material.dart';
import 'telecom_bill_page.dart';

class TelecomServiceSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Telecom Service')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelecomBillPage(
                      serviceName: 'Zain',
                      logoPath: 'lib/assets/zain.png',
                      amountDue: 15.00,
                    ),
                  ),
                );
              },
              child: const Text('Zain Bill Payment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelecomBillPage(
                      serviceName: 'Ooredoo',
                      logoPath: 'lib/assets/ooredoo.png',
                      amountDue: 20.00,
                    ),
                  ),
                );
              },
              child: const Text('Ooredoo Bill Payment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelecomBillPage(
                      serviceName: 'STC',
                      logoPath: 'lib/assets/stc.png',
                      amountDue: 18.00,
                    ),
                  ),
                );
              },
              child: const Text('STC Bill Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
