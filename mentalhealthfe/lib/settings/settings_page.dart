import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalhealthfe/settings/change_country.dart';
import 'package:mentalhealthfe/settings/change_password_page.dart';
import 'package:mentalhealthfe/settings/legal_about_page.dart';
import 'package:mentalhealthfe/settings/notifications_settings_page.dart';
import 'package:mentalhealthfe/welcome_screens/login-screen.dart';

import 'change_language_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkGrey = Color(0xFF333333);

    return CustomPaint(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'General',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: const Text('Language A / का'),
                              leading: const Icon(
                                Icons.language,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ChangeLanguagePage())),
                            ),
                            ListTile(
                              title: const Text('Change Country'),
                              leading: const Icon(
                                Icons.flag,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ChangeCountryPage())),
                            ),
                            ListTile(
                              title: const Text('Notifications'),
                              leading: const Icon(
                                Icons.notifications,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const NotificationSettingsPage())),
                            ),
                            ListTile(
                              title: const Text('Legal & About'),
                              leading: const Icon(
                                Icons.gavel,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const LegalAboutPage())),
                            ),
                            ListTile(
                              title: const Text('About Us'),
                              leading: const Icon(
                                Icons.info_outline_rounded,
                              ),
                              onTap: () {},
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: const Text('Change Password'),
                              leading: const Icon(
                                Icons.key,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ChangePasswordPage())),
                            ),
                            ListTile(
                              title: const Text('Sign out'),
                              leading: const Icon(
                                Icons.logout,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen())),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
