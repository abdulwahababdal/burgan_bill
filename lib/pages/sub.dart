import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'subscription_success_page.dart';

class SubscriptionPage extends StatefulWidget {
  final String serviceName;
  final String logoPath;

  final List<SubscriptionOption> options;

  const SubscriptionPage({
    Key? key,
    required this.serviceName,
    required this.logoPath,
    required this.options,
  }) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedIndex = 0;
  bool _autoRenew = false;

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
          titleLarge:
              TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.amber),
          trackColor: MaterialStateProperty.all(Colors.grey),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose ${widget.serviceName} Subscription'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/dashboard'); // Back button goes to the dashboard
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
              const Text(
                'Select Your Plan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...widget.options.asMap().entries.map((entry) {
                int index = entry.key;
                SubscriptionOption option = entry.value;
                return Column(
                  children: [
                    SubscriptionOptionCard(
                      title: option.title,
                      price: option.price,
                      features: option.features,
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Auto-Renew Subscription'),
                  Switch(
                    value: _autoRenew,
                    onChanged: (value) {
                      setState(() {
                        _autoRenew = value;
                      });
                    },
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push('/subscription-success');
                },
                child: const Text('Subscribe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionOption {
  final String title;
  final String price;
  final List<String> features;

  SubscriptionOption({
    required this.title,
    required this.price,
    required this.features,
  });
}

class SubscriptionOptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionOptionCard({
    Key? key,
    required this.title,
    required this.price,
    required this.features,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blue[100] : Theme.of(context).cardColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(price, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    features.map((feature) => Text('• $feature')).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
