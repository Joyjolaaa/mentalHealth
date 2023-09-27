// ignore_for_file: unnecessary_import, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    const Color darkGrey = Color(0xFF333333);
    const Color green = Color(0xff23aa49);
    double baseWidth = 390;
    double baseHeight = 844;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fem = screenWidth / baseWidth;
    double ffem = fem * 0.97;

    double availableHeight = screenHeight - MediaQuery.of(context).padding.top;
    double responsiveHeight = baseHeight * fem;

    if (responsiveHeight > availableHeight) {
      fem = availableHeight / baseHeight;
      ffem = fem * 0.97;
      responsiveHeight = availableHeight;
    }

    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = ElevatedButton(
      onPressed: () {
        // Add your button's onPressed logic here
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(double.infinity, 53 * fem),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100 * fem),
        ),
        backgroundColor: const Color(0xff23aa49),
      ),
      child: Text(
        'Change Password',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16 * ffem,
          fontWeight: FontWeight.w700,
          height: 1.3025 * ffem / fem,
          color: const Color(0xffffffff),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15, top: 16.0),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Enter your current Password',
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3025 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Enter your new Password',
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3025 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Retype your new password',
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3025 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: bottomPadding != 20 ? 20 : bottomPadding),
                          width: width,
                          child: Center(child: changePasswordButton),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
