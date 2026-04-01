import 'package:expenso_464/ui/add_expense/add_expense_page.dart';
import 'package:expenso_464/ui/dashboard/nav_pages/noti_page.dart';
import 'package:flutter/material.dart';

import '../../domain/constants/app_routes.dart';
import 'nav_pages/home_page.dart';
import 'nav_pages/profile_page.dart';
import 'nav_pages/stats_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentNavPageIndex = 0;

  List<Widget> mPages = [
    HomeNavPage(),
    StatsNavPage(),
    AddExpensePage(),
    NotificationNavPage(),
    ProfileNavPage(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mPages[currentNavPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 11,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: currentNavPageIndex,
        onTap: (value){
          if(value==2){
            Navigator.pushNamed(context, AppRoutes.addExpense);
          } else {
            currentNavPageIndex = value;
            setState(() {

            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "",
            activeIcon: Icon(Icons.home_filled, color: Colors.pink.shade200)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "",
              activeIcon: Icon(Icons.bar_chart_outlined, color: Colors.pink.shade200)
          ),
          BottomNavigationBarItem(
              icon: Container(
                width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Icon(Icons.add, color: Colors.white,)),
              label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              label: "",
              activeIcon: Icon(Icons.notifications_rounded, color: Colors.pink.shade200)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "",
              activeIcon: Icon(Icons.account_circle, color: Colors.pink.shade200)
          ),
        ],
      ),
    );
  }
}
