import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:burgan_bill/testdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listScrollController = ScrollController();
  ScrollDirection scrollDirection = ScrollDirection.idle;

  final List<Map<String, String>> itemList = [
    {'name': 'Telecom Service'},
    {'name': 'Subscription Service'},
    {'name': 'Coming Soon'}
  ];

  final List<Map<String, String>> transactionHistory = [
    {'date': '2023-10-01', 'amount': '-\$20', 'description': 'Grocery'},
    {'date': '2023-09-28', 'amount': '+\$500', 'description': 'Salary'},
    {'date': '2023-09-25', 'amount': '-\$50', 'description': 'Utilities'},
    {'date': '2023-09-20', 'amount': '-\$30', 'description': 'Transport'},
    {'date': '2023-09-15', 'amount': '-\$70', 'description': 'Shopping'},
  ];

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(() {
      setState(() {
        scrollDirection = listScrollController.position.userScrollDirection;
      });
    });
  }

  bool _scrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      setState(() {
        scrollDirection = ScrollDirection.idle;
      });
    }
    return true;
  }

  void _onCardTap(String itemName) {
    switch (itemName) {
      case 'Telecom Service':
        context.go('/telecom-selection'); // Navigate to telecom selection page
        break;
      case 'Subscription Service':
        context.go(
            '/subscription-selection'); // Navigate to subscription selection page
        break;
      case 'Coming Soon':
        // No action or show a message
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.amber[400],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Balance: \$5000',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height: 150,
              width: 400,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: NotificationListener<ScrollNotification>(
                onNotification: _scrollNotification,
                child: ListView(
                  controller: listScrollController,
                  scrollDirection: Axis.horizontal,
                  children: itemList.map((item) {
                    return GestureDetector(
                      onTap: () => _onCardTap(item['name']!),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        transform: Matrix4.rotationZ(
                            scrollDirection == ScrollDirection.forward
                                ? 0.07
                                : scrollDirection == ScrollDirection.reverse
                                    ? -0.07
                                    : 0),
                        width: 220,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(-6, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item['name']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Explore',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction History',
              style: TextStyle(
                color: Colors.amber[400],
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transactionHistory.length,
              itemBuilder: (context, index) {
                final transaction = transactionHistory[index];
                return ListTile(
                  leading: Icon(Icons.attach_money, color: Colors.white),
                  title: Text(
                    transaction['description']!,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    transaction['date']!,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  trailing: Text(
                    transaction['amount']!,
                    style: TextStyle(
                      color: transaction['amount']!.startsWith('-')
                          ? Colors.redAccent
                          : Colors.greenAccent,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.go('/chart');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(
                'View Chart',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
