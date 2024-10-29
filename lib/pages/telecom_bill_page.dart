import 'package:flutter/material.dart';
import 'bill_amount_page.dart';

class TelecomBillPage extends StatefulWidget {
  final String serviceName;
  final String logoPath;
  final double amountDue;

  const TelecomBillPage({
    super.key,
    required this.serviceName,
    required this.logoPath,
    required this.amountDue,
  });

  @override
  _TelecomBillPageState createState() => _TelecomBillPageState();
}

class _TelecomBillPageState extends State<TelecomBillPage> {
  final _phoneController = TextEditingController();
  bool _isValidNumber = true;

  void _checkPhoneNumber() {
    final phoneNumber = _phoneController.text;
    if (phoneNumber.length == 8 && int.tryParse(phoneNumber) != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BillAmountPage(
            serviceName: widget.serviceName,
            logoPath: widget.logoPath,
            amountDue: widget.amountDue,
          ),
        ),
      );
    } else {
      setState(() {
        _isValidNumber = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.serviceName} Bill Payment'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo at the top
            Center(
              child: Image.asset(
                widget.logoPath,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Enter Phone Number
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Enter 8-digit Phone Number',
                errorText: _isValidNumber
                    ? null
                    : 'Please enter a valid 8-digit number',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Proceed Button
            ElevatedButton(
              onPressed: _checkPhoneNumber,
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
