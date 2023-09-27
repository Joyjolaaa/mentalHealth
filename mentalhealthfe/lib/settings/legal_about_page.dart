// ignore_for_file: unused_local_variable, unnecessary_import, unused_import, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LegalAboutPage extends StatefulWidget {
  const LegalAboutPage({super.key});

  @override
  _LegalAboutPageState createState() => _LegalAboutPageState();
}

class _LegalAboutPageState extends State<LegalAboutPage> {
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
                  'Legal & About',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      title: Text('Terms of Use'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('License'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('Seller Policy'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      title: Text('Return Policy'),
                      trailing: Icon(Icons.chevron_right),
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
