import 'package:flutter/material.dart';
import 'sub.dart';

class SubscriptionSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Subscription Service')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Netflix Subscription
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPage(
                      serviceName: 'Netflix',
                      logoPath: 'lib/assets/netflix.png',
                      options: [
                        SubscriptionOption(
                          title: 'Monthly Subscription',
                          price: '3.00 KWD per month',
                          features: [
                            'HD available',
                            'Watch on 1 screen',
                            'Cancel anytime'
                          ],
                        ),
                        SubscriptionOption(
                          title: 'Yearly Subscription',
                          price: '30.00 KWD per year',
                          features: [
                            'HD available',
                            'Watch on 2 screens',
                            'Cancel anytime'
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Netflix Subscription'),
            ),
            const SizedBox(height: 20),

            // Disney+ Subscription
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPage(
                      serviceName: 'Disney+',
                      logoPath: 'lib/assets/disney.png',
                      options: [
                        SubscriptionOption(
                          title: 'Monthly Subscription',
                          price: '2.70 KWD per month',
                          features: [
                            '4K UHD available',
                            'Watch on 2 screens',
                            'Cancel anytime'
                          ],
                        ),
                        SubscriptionOption(
                          title: 'Yearly Subscription',
                          price: '27.00 KWD per year',
                          features: [
                            '4K UHD available',
                            'Watch on 4 screens',
                            'Cancel anytime'
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Disney+ Subscription'),
            ),
            const SizedBox(height: 20),

            // HBO Subscription
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPage(
                      serviceName: 'HBO',
                      logoPath: 'lib/assets/hbo.png',
                      options: [
                        SubscriptionOption(
                          title: 'Monthly Subscription',
                          price: '4.50 KWD per month',
                          features: [
                            'HD available',
                            'Watch on 3 screens',
                            'Cancel anytime'
                          ],
                        ),
                        SubscriptionOption(
                          title: 'Yearly Subscription',
                          price: '45.00 KWD per year',
                          features: [
                            'HD available',
                            'Watch on 5 screens',
                            'Cancel anytime'
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('HBO Subscription'),
            ),
            const SizedBox(height: 20),

            // Amazon Prime Subscription
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPage(
                      serviceName: 'Amazon Prime',
                      logoPath: 'lib/assets/prime.png',
                      options: [
                        SubscriptionOption(
                          title: 'Monthly Subscription',
                          price: '3.90 KWD per month',
                          features: [
                            'HD available',
                            'Watch on 2 screens',
                            'Cancel anytime'
                          ],
                        ),
                        SubscriptionOption(
                          title: 'Yearly Subscription',
                          price: '36.00 KWD per year',
                          features: [
                            'HD available',
                            'Watch on 4 screens',
                            'Cancel anytime'
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Amazon Prime Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}
