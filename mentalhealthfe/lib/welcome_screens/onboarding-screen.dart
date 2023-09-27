// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sdlc_flutter/app_properties.dart';
import 'package:sdlc_flutter/welcome_screens/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
//      width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          image: const DecorationImage(
            image: AssetImage('images/background-02.png'),
            fit: BoxFit.contain, // Change the image to green
          ),
        ),
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              controller: controller,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'images/sdlc.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Find the Best Fit SDLC model',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 251, 251, 251)),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                      child: Text(
                        'You can find a best fit model with just few parameters',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color.fromARGB(255, 251, 251, 251),
                            fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'images/sdlc.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Available anytime ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 251, 251, 251)),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                      child: Text(
                        'You can just in few clicks take the best decision',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color.fromARGB(255, 251, 251, 251),
                            fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'images/sdlc.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Artificially Intelligent',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 251, 251, 251)),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                      child: Text(
                        'An intelligent model to help you predict your model outcome',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color.fromARGB(255, 251, 251, 251),
                            fontSize: 13.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 0 ? green : Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 1 ? green : Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 2 ? green : Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Opacity(
                          opacity: pageIndex != 2 ? 1.0 : 0.0,
                          child: TextButton(
                            child: const Text(
                              'SKIP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                          ),
                        ),
                        pageIndex != 2
                            ? TextButton(
                                child: const Text(
                                  'NEXT',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  if (!(controller.page == 2.0)) {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  }
                                },
                              )
                            : TextButton(
                                child: const Text(
                                  'FINISH',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen()));
                                },
                              )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
