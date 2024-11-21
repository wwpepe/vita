import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/add_scree.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // 각 탭에 해당하는 화면
  final List<Widget> _screens = [
    HomeScreen(),
    AddScreen(),
    AnalyticScreen(),
    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 24),
            children: [
              TextSpan( text: 'Vi', style: TextStyle(color: Color(0xFF8DC63F), fontWeight: FontWeight.bold)),
              TextSpan( text: 'TA', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold )),
              TextSpan( text: ' Safe Driving Assistant',style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.normal,fontSize: 18,))
            ],
          ),
        )
      ),
      body: _screens[_selectedIndex], // 선택된 화면 표시
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Color(0xFFBBF246), fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFBBF246),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:[
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 0 ? Color(0xFFBBF246) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home, color:_selectedIndex == 0 ? Colors.black : Colors.white),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 1 ? Color(0xFFBBF246) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color:_selectedIndex == 1 ? Colors.black : Colors.white),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Color(0xFFBBF246) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bar_chart, color: _selectedIndex == 2 ? Colors.black : Colors.white),
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 3 ? Color(0xFFBBF246) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: _selectedIndex == 3 ? Colors.black : Colors.white),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
