import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  int _selectedIndex = 2;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _logout() {
    context.pop();
  }

  void _navigateToProfile() {
    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.amber[400]),
        ),
        backgroundColor: _isDarkMode ? Colors.black : Colors.grey[900],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.amber[400]),
            title: Text(
              'Profile',
              style:
                  TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
            onTap: _navigateToProfile,
          ),
          SwitchListTile(
            activeColor: Colors.amber[400],
            title: Text(
              'Dark Mode',
              style:
                  TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
            value: _isDarkMode,
            onChanged: _toggleDarkMode,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text(
              'Logout',
              style:
                  TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
            ),
            onTap: _logout,
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.grey[900],
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_balance_wallet),
      //       label: 'Subscriptions',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[400],
      //   unselectedItemColor: Colors.grey[500],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.amber[400])),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Text(
          'Profile Page Content',
          style: TextStyle(fontSize: 24, color: Colors.amber[400]),
        ),
      ),
    );
  }
}
