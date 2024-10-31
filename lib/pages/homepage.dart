import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:burgan_bill/provider/transaction_provider.dart';
import 'package:burgan_bill/testdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'settings_page.dart';
import 'package:provider/provider.dart';
import 'package:burgan_bill/provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  void Function(int)? onCardClick;

  HomePage({this.onCardClick});
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

  // final List<Map<String, String>> transactionHistory = [
  //   {'date': '2023-10-01', 'amount': '-\$20', 'description': 'Grocery'},
  //   {'date': '2023-09-28', 'amount': '+\$500', 'description': 'Salary'},
  //   {'date': '2023-09-25', 'amount': '-\$50', 'description': 'Utilities'},
  //   {'date': '2023-09-20', 'amount': '-\$30', 'description': 'Transport'},
  //   {'date': '2023-09-15', 'amount': '-\$70', 'description': 'Shopping'},
  // ];

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

  List<Widget> pages = [
    HomePage(),
    TelecomAndSubscriptionSelectionPage(),
    SettingsPage(),
  ];
  void _onCardTap(String itemName) {
    switch (itemName) {
      case 'Telecom Service':
        widget.onCardClick?.call(1);
        break;
      case 'Subscription Service':
        widget.onCardClick?.call(1);
        break;
      case 'Coming Soon':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode ? Colors.grey[850] : Colors.white,
          appBar: AppBar(
            backgroundColor:
                themeProvider.isDarkMode ? Colors.grey[900] : Colors.grey[800],
            title: Text(
              "Dashboard",
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? Colors.amber[400]
                    : Colors.amber[400],
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
                  height: 180,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeProvider.isDarkMode
                          ? [Colors.amber[800]!, Colors.amber[400]!]
                          : [Colors.amber[900]!, Colors.amber[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Monthly Expenses',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${context.read<TransactionProvider>().totalexpenses} KWD",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Current Total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                    color: themeProvider.isDarkMode
                        ? Colors.amber[400]
                        : Colors.amber[700],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<TransactionProvider>(builder: (context, provider, _) {
                  var transactionHistory = provider.transactions;

                  if (transactionHistory.isEmpty) {
                    return Center(
                      child: Text("No transations"),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: transactionHistory.length,
                    itemBuilder: (context, index) {
                      final transaction = transactionHistory[index];
                      return ListTile(
                        leading: Icon(Icons.attach_money, color: Colors.white),
                        title: Text(
                          transaction.serviceName,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "${transaction.date.year}-${transaction.date.month}-${transaction.date.day}",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        trailing: Text(
                          transaction.amount.toString().padRight(2, '0'),
                          style: TextStyle(
                            color: transaction.amount < 0
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                        ),
                      );
                    },
                  );
                }),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
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
      },
    );
  }
}
