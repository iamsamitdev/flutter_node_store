import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_node_store/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.hello,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
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
                        title: const Text('Select Language'),
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
                                    provider.changeLocale(const Locale('en'));
                                    Navigator.pop(context);
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
                                    provider.changeLocale(const Locale('th'));
                                    Navigator.pop(context);
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
                                    provider.changeLocale(const Locale('zh'));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
