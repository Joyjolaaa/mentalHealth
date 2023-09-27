// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sdlc_flutter/account/faq_page.dart';
import 'package:sdlc_flutter/api_services/api_service.dart';
import 'package:sdlc_flutter/app_properties.dart';
import 'package:sdlc_flutter/models/user.dart';
import 'package:sdlc_flutter/settings/settings_page.dart';

// Import the ApiService and User models here

class ProfilePage extends StatefulWidget {
  final String? authToken;

  const ProfilePage({Key? key, required this.authToken}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Define a variable to hold the user details
  List<User> users = [];


  @override
  void initState() {
    super.initState();
    _fetchUserDetails(); // Fetch user details when the page is loaded
  }

  Future<void> _fetchUserDetails() async {
  // Get the authentication token from wherever you saved it after login
  String? authToken = widget.authToken;

  User? user = await ApiService.getUserDetails(authToken!);

  if (user != null) {
    setState(() {
      users = [user]; // Convert the single User object to a list
    });
  }
}


  @override
  Widget build(BuildContext context) {
    MQuery().init(context);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: kToolbarHeight,
            ),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage(
                      users[0].profile.avatar ?? 'images/background.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    users.isNotEmpty ? '${users[0].first_name} ${users[0].last_name}' : 'Firstname Last Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: green,
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.contact_emergency,
                              ),
                              onPressed: () {},
                            ),
                            const Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Settings'),
                  subtitle: const Text('Privacy and logout'),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  trailing: const Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SettingsPage(),
                    ),
                  ),
                ),
                
                const Divider(),
                const ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Icon(
                    Icons.support,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: green,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('FAQ'),
                  subtitle: const Text('Questions and Answer'),
                  leading: const Icon(
                    Icons.help_outline,
                  ),
                  trailing: const Icon(Icons.chevron_right, color: green),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FaqPage(),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
