// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_node_store/app_router.dart';
import 'package:flutter_node_store/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/notification_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/profile_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/report_screen.dart';
import 'package:flutter_node_store/screens/bottomnavpage/setting_screen.dart';
import 'package:flutter_node_store/themes/colors.dart';
import 'package:flutter_node_store/utils/utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  // ส่วนของการสร้าง Bottom Navigation Bar ---------------------------------
  // สร้างตัวแปรเก็บ title ของแต่ละหน้า
  String _title = 'Flutter Store';

  // สร้างตัวแปรเก็บ index ของแต่ละหน้า
  int _currentIndex = 0;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // ฟังก์ขันในการเปลี่ยนหน้า โดยรับค่า index จากการกดที่ bottomNavigationBar
  void onTabTapped(int index) {
    setState(
      () {
        _currentIndex = index;
        switch (index) {
          case 0:
            _title = 'Home';
            break;
          case 1:
            _title = 'Report';
            break;
          case 2:
            _title = 'Notification';
            break;
          case 3:
            _title = 'Setting';
            break;
          case 4:
            _title = 'Profile';
            break;
          default:
            _title = 'Flutter Store';
        }
      },
    );
  }
  // ---------------------------------------------------------------------------

  // Logout function -----------------------------------------------------------
  _logout() {
    // Remove token, loginStatus shared preference
    Utility.removeSharedPreference('token');
    Utility.removeSharedPreference('loginStatus');

    // Clear all route and push to login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        backgroundColor: primary,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  margin: EdgeInsets.only(bottom: 0.0),
                  accountName: Text('Samit Koyom'),
                  accountEmail: Text('samit@email.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/samitk.jpg'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/noavartar.png'),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.timer_outlined, color: icons,),
                  title: Text('Counter (With Stateful)', style: TextStyle(color: icons,),),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.counterStateful);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.timer_outlined, color: icons,),
                  title: Text('Counter (With Provider)', style: TextStyle(color: icons,),),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.counterProvider);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline, color: icons,),
                  title: Text('Info',style: TextStyle(color: icons,),),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_outline, color: icons,),
                  title: Text('About', style: TextStyle(color: icons,),),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, color: icons,),
                  title: Text('Contact', style: TextStyle(color: icons,),),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.exit_to_app_outlined, color: icons,),
                    title: Text('Logout', style: TextStyle(color: icons,),),
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // endDrawer: Drawer(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          onTabTapped(value);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.menu_setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile,
          ),
        ]
      ),
    );
  }
}
