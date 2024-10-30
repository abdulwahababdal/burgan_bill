import 'package:burgan_bill/pages/homepage.dart';
import 'package:burgan_bill/pages/subscription_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  int _selectedIndex = 2;
  String? _selectedAccountType;
  String _email = '';
  List<Map<String, String>> _accounts = [];
  final TextEditingController _emailController = TextEditingController();

  // Bill Reminder-specific variables
  String? _selectedBillType; // Selected bill type for reminder
  bool _enableBillReminder = false;
  String? _reminderFrequency = '1 day before';
  Map<String, dynamic> _billReminders =
      {}; // Stores reminders for each bill type

  // Telecom-specific variables
  String? _selectedTelecomProvider;
  String _phoneNumber = '';
  List<Map<String, String>> _telecomAccounts = [];
  final TextEditingController _phoneController = TextEditingController();

  // Map to hold account types and corresponding image paths
  final Map<String, String> _accountIcons = {
    'HBO': 'assets/images/hbo.png',
    'Netflix': 'assets/images/netflix.png',
    'Disney+': 'assets/images/disney.png',
    'Amazon Prime': 'assets/images/prime.png',
  };

  // Map to hold telecom providers and corresponding image paths
  final Map<String, String> _telecomIcons = {
    'Zain': 'assets/images/zain.png',
    'Ooredoo': 'assets/images/ooredoo.png',
    'STC': 'assets/images/stc.png',
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      String? savedAccounts = prefs.getString('accounts');
      if (savedAccounts != null) {
        List<dynamic> accountList = json.decode(savedAccounts);
        _accounts = accountList
            .map((account) => Map<String, String>.from(account))
            .toList();
      }

      String? savedTelecomAccounts = prefs.getString('telecomAccounts');
      if (savedTelecomAccounts != null) {
        List<dynamic> telecomList = json.decode(savedTelecomAccounts);
        _telecomAccounts = telecomList
            .map((telecom) => Map<String, String>.from(telecom))
            .toList();
      }

      // Load bill reminders
      String? savedBillReminders = prefs.getString('billReminders');
      if (savedBillReminders != null) {
        _billReminders = json.decode(savedBillReminders);
      }
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    String encodedAccounts = json.encode(_accounts);
    await prefs.setString('accounts', encodedAccounts);
    String encodedTelecomAccounts = json.encode(_telecomAccounts);
    await prefs.setString('telecomAccounts', encodedTelecomAccounts);
    String encodedBillReminders = json.encode(_billReminders);
    await prefs.setString('billReminders', encodedBillReminders);
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    _savePreferences();
  }

  void _toggleBillReminder(bool value) {
    setState(() {
      _enableBillReminder = value;
      if (_selectedBillType != null) {
        _billReminders[_selectedBillType!] = {
          'enabled': value,
          'frequency': _reminderFrequency,
        };
      }
    });
    _savePreferences();
  }

  void _setReminderFrequency(String? frequency) {
    setState(() {
      _reminderFrequency = frequency;
      if (_selectedBillType != null) {
        _billReminders[_selectedBillType!] = {
          'enabled': _enableBillReminder,
          'frequency': frequency,
        };
      }
    });
    _savePreferences();
  }

  void _logout() {
    Navigator.pop(context);
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TelecomAndSubscriptionSelectionPage()),
        );
        break;
      case 2:
        break;
    }
  }

  void _addAccount() {
    if (_selectedAccountType != null && _email.isNotEmpty) {
      setState(() {
        _accounts.add({
          'type': _selectedAccountType!,
          'email': _email,
        });
        _selectedAccountType = null;
        _email = '';
        _emailController.clear();
      });
      _savePreferences();
    }
  }

  void _addTelecomAccount() {
    if (_selectedTelecomProvider != null && _phoneNumber.length == 8) {
      setState(() {
        _telecomAccounts.add({
          'provider': _selectedTelecomProvider!,
          'phone': _phoneNumber,
        });
        _selectedTelecomProvider = null;
        _phoneNumber = '';
        _phoneController.clear();
      });
      _savePreferences();
    }
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
          Card(
            margin: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Accounts',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                DropdownButton<String>(
                  hint: Text("Select Account Type"),
                  value: _selectedAccountType,
                  items: ['HBO', 'Netflix', 'Disney+', 'Amazon Prime']
                      .map((String account) {
                    return DropdownMenuItem<String>(
                      value: account,
                      child: Text(account),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAccountType = newValue;
                    });
                  },
                ),
                if (_selectedAccountType != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        hintText: 'example@example.com',
                      ),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ElevatedButton(
                  onPressed: _addAccount,
                  child: Text('Add Account'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[400]),
                ),
                ..._accounts.map((account) => ListTile(
                      title: Text(
                        '${account['email']}',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black),
                      ),
                      leading: Image.asset(
                        _accountIcons[account['type']]!,
                        width: 40,
                        height: 40,
                      ),
                    )),
              ],
            ),
          ),
          Card(
            color: _isDarkMode ? Colors.grey[800] : Colors.white,
            margin: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Telecom Accounts',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                DropdownButton<String>(
                  hint: Text("Select Telecom Provider"),
                  value: _selectedTelecomProvider,
                  items: ['Zain', 'Ooredoo', 'STC'].map((String provider) {
                    return DropdownMenuItem<String>(
                      value: provider,
                      child: Text(provider),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTelecomProvider = newValue;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Enter 8-digit Phone Number',
                      hintText: '12345678',
                    ),
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _phoneNumber = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTelecomAccount,
                  child: Text('Add Telecom Account'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[400]),
                ),
                ..._telecomAccounts.map((telecom) => ListTile(
                      title: Text(
                        '${telecom['phone']}',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black),
                      ),
                      leading: Image.asset(
                        _telecomIcons[telecom['provider']]!,
                        width: 40,
                        height: 40,
                      ),
                    )),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Bill Reminders',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                DropdownButton<String>(
                  hint: Text("Select Bill Type"),
                  value: _selectedBillType,
                  items: ['Netflix', 'Zain', 'Ooredoo', 'STC', 'HBO', 'Disney+']
                      .map((String bill) {
                    return DropdownMenuItem<String>(
                      value: bill,
                      child: Text(bill),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBillType = newValue;
                      _enableBillReminder = _billReminders[_selectedBillType]
                              ?['enabled'] ??
                          false;
                      _reminderFrequency = _billReminders[_selectedBillType]
                              ?['frequency'] ??
                          '1 day before';
                    });
                  },
                ),
                if (_selectedBillType != null) ...[
                  SwitchListTile(
                    activeColor: Colors.amber[400],
                    title: Text(
                      'Enable Reminder for $_selectedBillType',
                      style: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    value: _enableBillReminder,
                    onChanged: _toggleBillReminder,
                  ),
                  if (_enableBillReminder)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        hint: Text("Select Reminder Frequency"),
                        value: _reminderFrequency,
                        items: [
                          '1 day before',
                          '3 days before',
                          '1 week before'
                        ].map((String frequency) {
                          return DropdownMenuItem<String>(
                            value: frequency,
                            child: Text(frequency),
                          );
                        }).toList(),
                        onChanged: _setReminderFrequency,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
