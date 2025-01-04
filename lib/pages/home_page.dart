import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api/model/user_model.dart';
import 'package:user_api/pages/user_page.dart';

const baseUrl = "https://dummyjson.com/users";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userDetails = [];
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
                ? const Center(
                    child: Text("No data found"),
                  )
                : ListView.builder(
                    itemCount: userDetails.length,
                    itemBuilder: (context, index) {
                      var user = userDetails[index];
                      return ListTile(
                        leading: Image.network(user.image.toString()),
                        title: Text(
                            "${user.firstName!} ${user.lastName!} ${user.maidenName!}"),
                        // title: Text(
                        //     "${user["firstName"]} ${user["lastName"]} ${user["maidenName"]}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPage(
                                userModel: userDetails[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ));
  }

  void fetchUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body["users"];
        List<dynamic> dynamicUsers = data;
        List<UserModel> myUsers =
            dynamicUsers.map((e) => UserModel.fromJson(e)).toList();
        log(dynamicUsers.toString());

        setState(() {
          userDetails = myUsers;
        });
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("You have error $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
