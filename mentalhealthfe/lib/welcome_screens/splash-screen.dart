// ignore_for_file: file_names, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 35, 60, 170),
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          63 * fem, 265 * fem, 63 * fem, 403 * fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80, // Set the desired width
                            height: 80, // Set the desired height
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10.33, 19.89),
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(55 * fem),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 75.67 * fem,
                                  height: 56.11 * fem,
                                  child: Image.asset(
                                    'images/sdlc.png',
                                    width: 75.67 * fem,
                                    height: 56.11 * fem,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'SDLC MODEL',
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 37 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3025 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
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
