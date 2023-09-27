// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealthfe/utils.dart';
import 'package:mentalhealthfe/welcome_screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberOrEmailController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? authToken;

  bool usingFaceID = false;

  String? _phoneNumberOrEmailError;
  String? _passwordError;

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  void initState() {
    super.initState();
    fetchTokenFromLocalStorage();
  }

  Future<void> fetchTokenFromLocalStorage() async {
    final token = await getTokenFromLocalStorage();
    setState(() {
      authToken = token;
    });
  }

  Future<String?> getTokenFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }


  Future<void> saveTokenToLocalStorage(String? token) async {
    print('Token to be saved: $token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token ?? '');
  }

  Future<String?> authenticateUser(
      String phoneNumberOrEmail, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email_or_phone': phoneNumberOrEmail,
        'password': password,
      }),
    );

    print('Request Body: ${jsonEncode({
          'email_or_phone': phoneNumberOrEmail,
          'password': password,
        })}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'] as String?;
      if (token != null) {
        return token;
      } else {
        throw Exception('Token not found in response');
      }
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  void handleLogin(BuildContext context) async {
    final phoneNumberOrEmail = phoneNumberOrEmailController.text;
    final password = passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      return;
    }

    try {
      final token = await authenticateUser(phoneNumberOrEmail, password);
      setState(() {
        authToken = token;
      });

      // Save the token to local storage
      await saveTokenToLocalStorage(token);
      // Navigate to the home screen or any other desired screen
      Navigator.pushNamed(context, '/home-screen');
    } catch (error) {
      print(error);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid account number or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(21 * fem, 37 * fem, 21 * fem, 85 * fem),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 237, 249),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80, // Set the desired width
                  height: 80, // Set the desired height
                  child: Container(
                    // margin: const EdgeInsets.fromLTRB(119, 0, 119, 11),
                    padding: const EdgeInsets.fromLTRB(10, 20, 10.33, 19.89),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 75.67,
                        height: 56.11,
                        child: Image.asset(
                          'images/sdlc.png',
                          width: 75.67,
                          height: 56.11,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin:
                      EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 10 * fem),
                  child: Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'DM Sans',
                      fontSize: 28 * ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3025 * ffem / fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(1 * fem, 0 * fem, 0 * fem, 36 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 258 * fem,
                  ),
                  child: Text(
                    'Log in to your account using email',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'DM Sans',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.3025 * ffem / fem,
                      color: const Color(0xff979899),
                    ),
                  ),
                ),

                // form
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 62 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          child: TextFormField(
                            controller: phoneNumberOrEmailController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number/Email',
                              border: OutlineInputBorder(),
                            ),
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3025 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number or email is required';
                              }

                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$');

                              final phoneRegex = RegExp(
                                  r'^\+?\d{1,3}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');

                              if (!emailRegex.hasMatch(value) &&
                                  !phoneRegex.hasMatch(value)) {
                                return 'Please enter a valid phone number or email address';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _phoneNumberOrEmailError = null;
                              });
                            },
                          ),
                        ),
                        if (_phoneNumberOrEmailError != null)
                          Text(
                            _phoneNumberOrEmailError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          // height: 58 * fem,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3025 * ffem / fem,
                              color: const Color(0xff000000),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'Password must contain at least one uppercase letter';
                              }
                              if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return 'Password must contain at least one lowercase letter';
                              }
                              if (!RegExp(r'\d').hasMatch(value)) {
                                return 'Password must contain at least one digit';
                              }
                              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(value)) {
                                return 'Password must contain at least one special character';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _passwordError = null;
                              });
                            },
                          ),
                        ),
                        if (_passwordError != null)
                          Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here for the 'Forgot Password?' action
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'DM Sans',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3025 * ffem / fem,
                                color: const Color.fromARGB(255, 1, 46, 123),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic here for the 'Login' action
                            if (_formKey.currentState!.validate()) {
                              handleLogin(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color.fromARGB(255, 35, 73, 170),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                            side: const BorderSide(color: Color(0xff979899)),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 58 * fem,
                            child: Center(
                              child: Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'DM Sans',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3025 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: SafeGoogleFont(
                        'DM Sans',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.3020000458 * ffem / fem,
                        color: const Color(0xff000000),
                      ),
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.3025 * ffem / fem,
                            color: const Color(0xff000000),
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.3025 * ffem / fem,
                            color: const Color.fromARGB(255, 1, 21, 123),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
