import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_app/src/provider/bottom_navigation_controller.dart';
import 'package:zoom_app/src/screens/settings_screen.dart';
import 'package:zoom_app/src/screens/history_meeting_screen.dart';
import 'package:zoom_app/src/screens/meeting_screen.dart';
import 'package:zoom_app/src/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    const SettingsScreen(),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarController>(
      create: (context) => BottomNavigationBarController(),
      child: Consumer<BottomNavigationBarController>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            title: const Text('Meet & Chat'),
            centerTitle: true,
          ),
          body: pages[value.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: footerColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: value.onItemTapped,
            currentIndex: value.selectedIndex,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment_bank,
                ),
                label: 'Meet & Char',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                ),
                label: 'Meetings',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
