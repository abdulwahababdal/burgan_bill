import 'package:flutter/material.dart';
import 'subscription_success_page.dart';

class SubscriptionPage extends StatefulWidget {
  final String serviceName;
  final String logoPath;
  final List<SubscriptionOption> options;

  const SubscriptionPage({
    super.key,
    required this.serviceName,
    required this.logoPath,
    required this.options,
  });

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedIndex = 0;
  bool _autoRenew = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose ${widget.serviceName} Subscription'),
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
            // Service logo at the top
            Center(
              child: Image.asset(
                widget.logoPath,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Subscription Options
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
            // Auto-Renewal Switch
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
            // Subscribe Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionSuccessPage(),
                  ),
                );
              },
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}

// Subscription Option Model
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

// Subscription Option Card
class SubscriptionOptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionOptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blue[100] : Colors.white,
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
