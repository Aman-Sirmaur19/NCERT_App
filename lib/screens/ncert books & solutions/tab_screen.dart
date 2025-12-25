import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'subjects_screen.dart';

class TabScreen extends StatefulWidget {
  final String std;

  const TabScreen({super.key, required this.std});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = Constants.isEng ? 0 : 1;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': SubjectsScreen(std: widget.std),
      },
      {
        'page': SubjectsScreen(std: widget.std),
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      if (index == 0) {
        Constants.isEng = true;
      } else {
        Constants.isEng = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Text("🇬🇧", style: TextStyle(fontSize: 20)),
            label: 'English',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Text("🇮🇳", style: TextStyle(fontSize: 20)),
            label: 'हिंदी',
            backgroundColor: Colors.black87,
          ),
        ],
      ),
    );
  }
}
