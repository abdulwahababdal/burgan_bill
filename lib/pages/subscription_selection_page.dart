// telecom_and_subscription_selection_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'homepage.dart';
import 'settings_page.dart';
import 'telecom_bill_page.dart';
import 'sub.dart';

class TelecomAndSubscriptionSelectionPage extends StatefulWidget {
  @override
  _TelecomAndSubscriptionSelectionPageState createState() =>
      _TelecomAndSubscriptionSelectionPageState();
}

class _TelecomAndSubscriptionSelectionPageState
    extends State<TelecomAndSubscriptionSelectionPage> {
  final ScrollController _scrollControllerTelecom = ScrollController();
  final ScrollController _scrollControllerSubscription = ScrollController();
  ScrollDirection _scrollDirectionTelecom = ScrollDirection.idle;
  ScrollDirection _scrollDirectionSubscription = ScrollDirection.idle;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    _scrollControllerTelecom.addListener(() {
      setState(() {
        _scrollDirectionTelecom =
            _scrollControllerTelecom.position.userScrollDirection;
      });
    });

    _scrollControllerSubscription.addListener(() {
      setState(() {
        _scrollDirectionSubscription =
            _scrollControllerSubscription.position.userScrollDirection;
      });
    });
  }

  @override
  void dispose() {
    _scrollControllerTelecom.dispose();
    _scrollControllerSubscription.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        // Stay on TelecomAndSubscriptionSelectionPage
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Choose Service',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Telecom Services Section
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Telecom Services',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollControllerTelecom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceCard(
                  context,
                  serviceName: 'Zain',
                  logoPath: 'assets/images/zain.png',
                  onTap: () {
                    context.go(
                      '/telecom-bill',
                      extra: {
                        'serviceName': 'Zain',
                        'logoPath': 'assets/images/zain.png',
                        'amountDue': 15.00,
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionTelecom,
                ),
                const SizedBox(width: 10),
                _buildServiceCard(
                  context,
                  serviceName: 'Ooredoo',
                  logoPath: 'assets/images/ooredoo.png',
                  onTap: () {
                    context.go(
                      '/telecom-bill',
                      extra: {
                        'serviceName': 'Ooredoo',
                        'logoPath': 'assets/images/ooredoo.png',
                        'amountDue': 20.00,
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionTelecom,
                ),
                const SizedBox(width: 10),
                _buildServiceCard(
                  context,
                  serviceName: 'STC',
                  logoPath: 'assets/images/stc.png',
                  onTap: () {
                    context.go(
                      '/telecom-bill',
                      extra: {
                        'serviceName': 'STC',
                        'logoPath': 'assets/images/stc.png',
                        'amountDue': 18.00,
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionTelecom,
                ),
                const SizedBox(width: 10),
                _buildPlaceholderCard(context,
                    scrollDirection: _scrollDirectionTelecom),
                const SizedBox(width: 10),
                _buildPlaceholderCard(context,
                    scrollDirection: _scrollDirectionTelecom),
                const SizedBox(width: 10),
                _buildPlaceholderCard(context,
                    scrollDirection: _scrollDirectionTelecom),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Subscription Services Section
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Subscription Services',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollControllerSubscription,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildServiceCard(
                  context,
                  serviceName: 'Netflix',
                  logoPath: 'assets/images/netflix.png',
                  onTap: () {
                    context.go(
                      '/subscription',
                      extra: {
                        'serviceName': 'Netflix',
                        'logoPath': 'assets/images/netflix.png',
                        'options': [
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
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionSubscription,
                ),
                const SizedBox(width: 10),
                _buildServiceCard(
                  context,
                  serviceName: 'Disney+',
                  logoPath: 'assets/images/disney.png',
                  onTap: () {
                    context.go(
                      '/subscription',
                      extra: {
                        'serviceName': 'Disney+',
                        'logoPath': 'assets/images/disney.png',
                        'options': [
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
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionSubscription,
                ),
                const SizedBox(width: 10),
                _buildServiceCard(
                  context,
                  serviceName: 'HBO',
                  logoPath: 'assets/images/hbo.png',
                  onTap: () {
                    context.go(
                      '/subscription',
                      extra: {
                        'serviceName': 'HBO',
                        'logoPath': 'assets/images/hbo.png',
                        'options': [
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
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionSubscription,
                ),
                const SizedBox(width: 10),
                _buildServiceCard(
                  context,
                  serviceName: 'Amazon Prime',
                  logoPath: 'assets/images/prime.png',
                  onTap: () {
                    context.go(
                      '/subscription',
                      extra: {
                        'serviceName': 'Amazon Prime',
                        'logoPath': 'assets/images/prime.png',
                        'options': [
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
                      },
                    );
                  },
                  scrollDirection: _scrollDirectionSubscription,
                ),
                const SizedBox(width: 10),
                _buildPlaceholderCard(context,
                    scrollDirection: _scrollDirectionSubscription),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[400],
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String serviceName,
    required String logoPath,
    required VoidCallback onTap,
    required ScrollDirection scrollDirection,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.rotationZ(
            scrollDirection == ScrollDirection.forward
                ? 0.02
                : scrollDirection == ScrollDirection.reverse
                    ? -0.02
                    : 0,
          ),
          width: 140,
          height: 160,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber[400],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoPath,
                width: 60,
                height: 60,
              ),
              SizedBox(height: 10),
              Text(
                serviceName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderCard(BuildContext context,
      {required ScrollDirection scrollDirection}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.rotationZ(
          scrollDirection == ScrollDirection.forward
              ? 0.02
              : scrollDirection == ScrollDirection.reverse
                  ? -0.02
                  : 0,
        ),
        width: 140,
        height: 160,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 50,
              color: Colors.grey[600],
            ),
            SizedBox(height: 10),
            Text(
              'Placeholder',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
