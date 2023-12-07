import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_node_store/app_router.dart';
import 'package:flutter_node_store/providers/locale_provider.dart';
import 'package:flutter_node_store/providers/theme_provider.dart';
import 'package:flutter_node_store/themes/colors.dart';
import 'package:flutter_node_store/themes/styles.dart';
import 'package:flutter_node_store/utils/utility.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // อ่านข้อมูล profile จาก shared preference --------------------------------------
  String? _firstName, _lastName, _email;

  // สร้างฟังก์ชัน getUserProfile สำหรับอ่านข้อมูลจาก shared preference
  getUserProfile() async {
    var firstName = await Utility.getSharedPreference('firstName');
    var lastName = await Utility.getSharedPreference('lastName');
    var email = await Utility.getSharedPreference('email');

    setState(() {
      _firstName = firstName;
      _lastName = lastName;
      _email = email;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }
  // ---------------------------------------------------------------------------

  // Method Logout -----------------------------------------------------------
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
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildHeader(),
          _buildListMenu(),
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: provider.isDark,
                    onChanged: (value) {
                      // Toggle theme
                      provider.setTheme(
                        value ? AppTheme.darkTheme : AppTheme.lightTheme,
                      );
                    },
                  ),
                  Text(provider.isDark ? 'Dark Mode' : 'Light Mode'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // สร้าง widget สำหรับแสดงข้อมูล profile ที่อ่านมาจาก shared preference
  Widget _buildHeader() {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: provider.isDark ? primaryText : primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.hello,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/noavartar.png'),
              ),
              const SizedBox(height: 10),
              Text(
                '$_firstName $_lastName',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '$_email',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  // สร้าง widget สำหรับแสดงรายการเมนูต่างๆ
  Widget _buildListMenu() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.menu_account),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: Text(AppLocalizations.of(context)!.menu_changepass),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.menu_changelang),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            // Create alert dialog select language
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.menu_changelang),
                    content: SingleChildScrollView(
                      child: Consumer<LocaleProvider>(
                          builder: (context, provider, child) {
                        return ListBody(
                          children: [
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('English'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('en'));
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('ไทย'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('th'));
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('中國人'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('zh'));
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                  );
                });
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.menu_setting),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text(AppLocalizations.of(context)!.menu_logout),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: _logout,
        ),
      ],
    );
  }
}
