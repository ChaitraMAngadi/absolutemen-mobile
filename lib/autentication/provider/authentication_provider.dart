import 'dart:convert';

import 'package:absolutemen_app/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> signupformkey = GlobalKey<ScaffoldState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String result = '';

  final GlobalKey<ScaffoldMessengerState> messangerKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> register(
      String fname, String lname, String email, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:4000/app/sign-up'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'first_name': fname,
          'last_name': lname,
          'email': email,
          'phone': phone,
          // Add any other data you want to send in the body
        }),
      );

      if (response.statusCode == 201) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print(responseData);
        final snackbar =
            SnackBar(content: Text('User registered successfully'));

        result = "${responseData['first_name']}";

        notifyListeners();
      } else if (response.statusCode == 406) {
      } else {
        // result = '';
        notifyListeners();
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      result = '';
      notifyListeners();
      SnackBar(content: Text(e.toString()));
    }
  }
}
