import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/settings_page.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard ({super.key});

  @override
  State<Dashboard> createState () => _DashboardState();



}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0; 

  List<Widget> pages = [
     HomePage(),
     TelecomAndSubscriptionSelectionPage(),
     SettingsPage(),

  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: pages[pageIndex],

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: "Subscriptions"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        ]
      ),

    );

  }
}
  
