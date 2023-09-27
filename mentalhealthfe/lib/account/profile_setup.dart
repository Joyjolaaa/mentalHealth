// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentalhealthfe/api_services/api_service.dart';
import 'package:mentalhealthfe/models/profile.dart';
import 'package:mentalhealthfe/models/user.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String? authToken;

  const ProfileSetupScreen({required this.authToken, Key? key})
      : super(key: key);

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  TextEditingController bioController = TextEditingController();
  String? avatarFileUrl;
  File? avatarFile;

  void _saveProfile() async {
    if (widget.authToken != null &&
        widget.authToken!.isNotEmpty &&
        bioController.text.isNotEmpty) {
      Profile profile = Profile(
        avatar: avatarFileUrl ?? 'images/sdlc.png', // Set the avatar URL or path here
        bio: bioController.text,
      );

      User? createdUser = await ApiService.createProfile(
        widget.authToken!,
        profile,
        avatarFile, // Pass the avatarFile here
      );

      if (createdUser != null) {
        // Profile created successfully
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Profile created successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home-screen');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Failed to create profile
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: const Text('Error'),
        //       content: const Text('Failed to create profile.'),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     );
        //   },
        // );
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Details Submitted'),
              content: const Text('Proceed to Login'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home-screen');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle empty fields or missing authToken
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Missing fields or authToken.'),
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

  void _uploadImage() async {
    final ImagePicker _picker = ImagePicker();

    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        avatarFile = File(pickedFile.path);
        avatarFileUrl = pickedFile.path;
      });
    } else {
      print('Image picking canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _uploadImage,
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: avatarFileUrl != null
                      ? NetworkImage(avatarFileUrl!)
                      : (avatarFile != null
                          ? FileImage(avatarFile!)
                          : const AssetImage('images/avatar.jpg') as ImageProvider<
                              Object>?), // Add "as ImageProvider<Object>?" here
                  child: avatarFileUrl == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 32,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: bioController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tell us about yourself...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
