import 'package:burgan_bill/testdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var itemList = data;
  final listScrollController = ScrollController();
  ScrollDirection scrollDirection = ScrollDirection.idle;
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
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
      body: Column(
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
                children: data.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewListPage(
                            listName: 'List for ${item["name"]}',
                          ),
                        ),
                      );
                    },
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
                            'Item: ${item["name"]}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Go to List',
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
}

class NewListPage extends StatelessWidget {
  final String listName;

  NewListPage({required this.listName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          listName,
          style: TextStyle(
            color: Colors.amber[400],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Displaying $listName',
          style: TextStyle(fontSize: 24, color: Colors.amber[400]),
        ),
      ),
    );
  }
}
