import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://dummyjson.com/users/";

class UserPage extends StatefulWidget {
  final int userId;
  const UserPage({super.key, required this.userId});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map<String, dynamic> userDetails = {};
  bool isLoading = false;
  @override
  void initState() {
    fetchUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userDetails.isEmpty
              ? const Text("No data found")
              : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(userDetails["image"]),
                      Text(
                          "Name: ${userDetails["firstName"]} ${userDetails["lastName"]} ${userDetails["maidenName"]}"),
                      Text("Age: ${userDetails["age"]}"),
                      Text("Gender: ${userDetails["gender"]}"),
                      Text("Email: ${userDetails["email"]}"),
                      Text("Phone: ${userDetails["phone"]}"),
                      Text("Username: ${userDetails["username"]}"),
                      Text("Date of birth: ${userDetails["birthDate"]}"),
                      Text("Role: ${userDetails["role"]}"),
                    ],
                  ),
                ),
    );
  }

  fetchUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse("$baseUrl${widget.userId}"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        log(body.toString());
        setState(() {
          userDetails = body;
        });
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Error $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
