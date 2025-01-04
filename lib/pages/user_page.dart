import 'package:flutter/material.dart';
import 'package:user_api/model/user_model.dart';

// String baseUrl(id) => "https://dummyjson.com/users/$id";

class UserPage extends StatefulWidget {
  final UserModel userModel;
  const UserPage({super.key, required this.userModel});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map<String, dynamic> userDetails = {};
  bool isLoading = false;
  @override
  void initState() {
    // fetchUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.userModel.image!),
                  Text(widget.userModel.firstName!)
                ],
              ),
            ),
    );
  }

  // fetchUserDetails() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final response = await http.get(Uri.parse("$baseUrl(${widget.userId})"));
  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);

  //       log(body.toString());
  //       setState(() {
  //         userDetails = body;
  //       });
  //     } else {
  //       throw Exception("Failed to load users");
  //     }
  //   } catch (e) {
  //     throw Exception("Error $e");
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
}
