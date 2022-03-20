import 'package:flutter/material.dart';

class BottomNavigationBarController with ChangeNotifier{
  int selectedIndex = 0;

  onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}