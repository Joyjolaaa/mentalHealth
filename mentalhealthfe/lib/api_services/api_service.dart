// ignore_for_file: avoid_web_libraries_in_flutter, depend_on_referenced_packages, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'dart:html' as html;
import 'dart:typed_data'; // Import this for Uint8List
import 'package:http/http.dart' as http;
import 'package:mentalhealthfe/models/profile.dart';
import 'package:mentalhealthfe/models/user.dart';

class ApiService {
  static String baseUrl = 'http://localhost:8000';

  static Future<User?> getUserDetails(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return User.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<User>?> getRecentUsers(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/recent_users/'), // Assuming this is the endpoint to get recent users
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<User> recentUsers =
            jsonData.map((data) => User.fromJson(data)).toList();
        return recentUsers;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<User>?> getFrequentUsers(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/get_frequent_users/'), // Assuming this is the endpoint to get frequent users
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<User> frequentUsers =
            jsonData.map((data) => User.fromJson(data)).toList();
        return frequentUsers;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<User>?> getFavoriteUsers(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/get_favorite_users/'), // Assuming this is the endpoint to get favorite users
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<User> favoriteUsers =
            jsonData.map((data) => User.fromJson(data)).toList();
        return favoriteUsers;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> addFrequentUser(String authToken, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_frequent_user/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
        body: json.encode({'user_id': userId}),
      );

      if (response.statusCode == 201) {
        print('User added as frequent user');
        // You can perform any additional operations after a successful addition
      } else {
        print('Failed to add user as frequent user');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addFavoriteUser(String authToken, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_favorite_user/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
        body: json.encode({'user_id': userId}),
      );

      if (response.statusCode == 201) {
        print('User added as favorite user');
        // You can perform any additional operations after a successful addition
      } else {
        print('Failed to add user as favorite user');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> createProfile(
  String? authToken, Profile profile, File? avatarFile) async {
  try {
    final Uri uri = Uri.parse('$baseUrl/profile/');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Token $authToken';

    if (profile.bio != null) {
      request.fields['bio'] = profile.bio ?? '';
    }

    if (avatarFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        avatarFile.path,
      ));
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: $responseString');

    if (response.statusCode == 201) {
      if (responseString.isNotEmpty) {
        Map<String, dynamic> data = json.decode(responseString);
        return User.fromJson(data);
      } else {
        print('Response body is empty');
      }
    } else {
      print('Failed to create profile. Status code: ${response.statusCode}');
      // You can provide additional error handling here based on response status code
    }
  } catch (e) {
    print('Error creating profile: $e');
  }
  return null;
}

  static Future<User?> updateProfile(String authToken, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/profile/${user.email}/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $authToken",
        },
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        print('Failed to update profile');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
