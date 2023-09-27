// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously, depend_on_referenced_packages, must_be_immutable, unused_local_variable, unused_field, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdlc_flutter/account/profile_setup.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:libphonenumber/libphonenumber.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // final phoneNumberUtil = PhoneNumberUtil();

  String? _fullNameError;
  String? _phoneNumberError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? authToken;

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form

  Future<String> getCsrfToken() async {
    print('Fetching CSRF token...');
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/get-csrf-token/'));
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final csrfToken = json['csrfToken'] as String?;
      if (csrfToken != null) {
        return csrfToken;
      } else {
        throw Exception('CSRF token is null');
      }
    } else {
      throw Exception('Failed to fetch CSRF token');
    }
  }

  void _showRegistrationSuccessSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Registration successful!'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showRegistrationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Registration Successful',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16), // Increased padding here
                const Text(
                  'Your registration has been successful.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24), // Increased padding here
                Padding(
                  // Wrap the ElevatedButton with Padding and adjust padding
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileSetupScreen(authToken: authToken),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 79, 76, 175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      // Wrap the Text with Padding and adjust padding
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void register(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final csrfToken = await getCsrfToken(); // Fetch the CSRF token

        // Split the username into first name and last name
        List<String> nameParts = fullNameController.text.split(' ');
        String firstName = nameParts[0];
        String lastName = nameParts.length > 1 ? nameParts[1] : '';
        firstNameController.text = firstName;
        lastNameController.text = lastName;

        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/register/'),
          headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': csrfToken,
          },
          body: jsonEncode({
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'phone_number': phoneNumberController.text,
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Response body: ${response.body}');
        final jsonResponse = jsonDecode(response.body);
        print('Decoded JSON: $jsonResponse');

        if (response.statusCode == 201) {
          final jsonResponse = jsonDecode(response.body);
          authToken = jsonResponse['token'] as String?;
          final email = jsonResponse['email'] as String?;
          final detail = jsonResponse['detail'] as String?;

          _showRegistrationSuccessDialog(context);
        } else if (response.statusCode == 400) {
          final jsonResponse = jsonDecode(response.body);
          final email = jsonResponse['email'] as String;
          final token = jsonResponse['token'] as String;
          final detail = jsonResponse['detail'] as String;
          // Handle the case when the error message is not available
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Submission Failed'),
                content: const Text('Unknown error occurred'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(
                          email: email,
                          token: token,
                        ),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Submission Failed'),
                content: const Text('Unknown error occurred'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (error) {
      print('Error during registration: $error');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Submission Error'),
            content: Text('An error occurred during registration: $error'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 240, 249), // Set background color here
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(21, 37, 21, 35),
          width: double.infinity,
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
                    color: const Color.fromARGB(255, 255, 255, 255),
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
              const SizedBox(height: 20.0),
              const Text(
                'Create New Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Set up your account.\nYou can always change it later',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff979899),
                ),
              ),
              const SizedBox(height: 40.0),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 36),
                width: double.infinity,
                child: Form(
                  key: _formKey, // Assign the form key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full name is required';
                          }
                          List<String> nameParts = value.split(' ');
                          if (nameParts.length < 2) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _fullNameError = null;
                          });
                        },
                      ),
                      if (_fullNameError != null)
                        Text(
                          _fullNameError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _emailError = null;
                          });
                        },
                      ),
                      if (_emailError != null)
                        Text(
                          _emailError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20.0),

                      TextFormField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _fullNameError = null;
                          });
                        },
                      ),
                      if (_phoneNumberError != null)
                        Text(
                          _phoneNumberError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        keyboardType: TextInputType.number,
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
                      if (_passwordError != null)
                        Text(
                          _passwordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value != passwordController.text) {
                            return 'Password does not match';
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
                            _confirmPasswordError = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add your logic here for the 'Register' action
                          if (_formKey.currentState!.validate()) {
                            register(context);
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(
                              20.0), // Adjust the padding as needed
                          backgroundColor: const Color.fromARGB(255, 35, 58, 170),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Color(0xff979899)),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffffffff),
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
                  Navigator.pushNamed(context, '/login');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 1, 27, 123),
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
    );
  }
}

class VerificationScreen extends StatelessWidget {
  final String email;
  final String token;

  const VerificationScreen({Key? key, required this.email, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter the code',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform verification logic
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
