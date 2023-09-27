// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentalhealthfe/app_properties.dart';

class ChangeCountryPage extends StatefulWidget {
  const ChangeCountryPage({Key? key}) : super(key: key);

  @override
  _ChangeCountryPageState createState() => _ChangeCountryPageState();
}

class _ChangeCountryPageState extends State<ChangeCountryPage> {
  List<String> languages = [
    'China',
    'Spain',
    'United Kindom',
    'Romania',
    'Germany',
    'Portugal',
    'Bengal',
    'Russia',
    'Japan',
    'France',
  ];

  String currentCountry = '';

  @override
  Widget build(BuildContext context) {
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
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                  'Change Country',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: languages
                      .map((l) => ListTile(
                            onTap: () {
                              setState(() {
                                currentCountry = l;
                              });
                            },
                            title: Text(
                              l,
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: l == currentCountry
                                ? const Icon(
                                    Icons.check_circle,
                                    color: green,
                                    size: 16,
                                  )
                                : const SizedBox(),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
