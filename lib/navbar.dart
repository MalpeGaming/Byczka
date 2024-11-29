import 'package:flutter/material.dart';
import 'home.dart';
import 'score_n_progress/progress.dart';
import 'your_activities.dart';
import 'diet/nutrition_tips.dart';
import 'settings/settings.dart';
import 'package:page_transition/page_transition.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

int _selectedIndex = 2;

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: () {
            if (index == 0) {
              return const YourActivities();
            } else if (index == 1) {
              return const Progress();
            } else if (index == 3) {
              return const NutritionTips();
            } else if (index == 4) { // Correct index for Settings
              return const Settings();
            } else {
              return const Home();
            }
          }(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.primary,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        items: [
          buildMenuIcon(0, "Activities"),
          buildMenuIcon(1, "Progress"),
          buildCenterIcon(2, "Home"), // Center icon with special styling
          buildMenuIcon(3, "Diet"),
          buildMenuIcon(4, "Settings"), // Corrected index for Settings
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem buildMenuIcon(int index, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index
              ? Theme.of(context).colorScheme.onPrimary
              : Colors.transparent,
        ),
        child: ImageIcon(
          AssetImage(
            "assets/navbar_icons/${label.toLowerCase()}_${_selectedIndex == index ? 'on' : 'off'}_l.png",
          ),
          color: _selectedIndex == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
          size: _selectedIndex == index ? 28 : 24,
        ),
      ),
      label: label,
    );
  }

  BottomNavigationBarItem buildCenterIcon(int index, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: ImageIcon(
          AssetImage("assets/navbar_icons/${label.toLowerCase()}_on_l.png"),
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
      ),
      label: label,
    );
  }
}
