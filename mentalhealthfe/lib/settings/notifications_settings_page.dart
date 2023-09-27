// ignore_for_file: unused_local_variable, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool myOrders = true;
  bool reminders = true;
  bool newOffers = true;
  bool feedbackReviews = true;
  bool updates = true;

  Widget platformSwitch(bool val) {
    const Color green = Color(0xff23aa49);

    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: true,
        activeColor: green,
      );
    } else if (Platform.isAndroid) {
      return CupertinoSwitch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: true,
        activeColor: green,
      );
    } else if (kIsWeb) {
      // Use Switch for web platform (Chrome)
      return Switch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: val,
        activeColor: green,
      );
    } else {
      return Switch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: val,
        activeColor: green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color darkGrey = Color(0xFF333333);
    const Color green = Color(0xff23aa49);

    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: const Text('My orders'),
                      trailing: platformSwitch(myOrders),
                    ),
                    ListTile(
                      title: const Text('Reminders'),
                      trailing: platformSwitch(reminders),
                    ),
                    ListTile(
                      title: const Text('New Offers'),
                      trailing: platformSwitch(newOffers),
                    ),
                    ListTile(
                        title: const Text('Feedbacks and Reviews'),
                        trailing: platformSwitch(
                          feedbackReviews,
                        )),
                    ListTile(
                      title: const Text('Updates'),
                      trailing: platformSwitch(updates),
                    ),
                  ],
                ),
              ),
            
            
            ],
          ),
        ),
      ),
    );
  }
}
