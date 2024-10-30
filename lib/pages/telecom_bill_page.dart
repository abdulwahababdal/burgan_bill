import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bill_amount_page.dart';

class TelecomBillPage extends StatefulWidget {
  final String serviceName;
  final String logoPath;
  final double amountDue;

  const TelecomBillPage({
    Key? key,
    required this.serviceName,
    required this.logoPath,
    required this.amountDue,
  }) : super(key: key);

  @override
  _TelecomBillPageState createState() => _TelecomBillPageState();
}

class _TelecomBillPageState extends State<TelecomBillPage> {
  final _phoneController = TextEditingController();
  bool _isValidNumber = true;

  void _checkPhoneNumber() {
    final phoneNumber = _phoneController.text;
    if (phoneNumber.length == 8 && int.tryParse(phoneNumber) != null) {
      context.go(
        '/bill-amount',
        extra: {
          'serviceName': widget.serviceName,
          'logoPath': widget.logoPath,
          'amountDue': widget.amountDue,
        },
      );
    } else {
      setState(() {
        _isValidNumber = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          titleTextStyle: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.amber),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.grey[800]),
          titleLarge: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.amber,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.serviceName} Bill Payment'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/dashboard');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  widget.logoPath,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
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
              ElevatedButton(
                onPressed: _checkPhoneNumber,
                child: const Text('Proceed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
