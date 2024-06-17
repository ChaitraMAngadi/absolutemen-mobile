import 'dart:convert';

import 'package:absolutemen_app/routes/app_router.dart';
import 'package:absolutemen_app/services/secure_storage.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final inputcontroller = TextEditingController();
  final SecureStorage secureStorage = SecureStorage();

  @override
  void dispose() {
    inputcontroller.dispose();
    super.dispose();
  }

  Future<void> loginwithphone(String input, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.29.238:4000/app/log-in/phone-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'phone': input,
          // Add any other data you want to send in the body
        }),
      );

      if (response.statusCode == 202) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print(responseData);

        secureStorage.writeSecureData('token', responseData['token']);

        final sucessSnackbar = SnackBar(
            backgroundColor: Colors.green[400],
            content: Text(
              'OTP sent sucessfully',
              style: TextStyle(color: Colors.grey[50]),
            ));

        ScaffoldMessenger.of(context).showSnackBar(sucessSnackbar);
        context.router.popAndPush(OtpVerificationRoute());
      } else if (response.statusCode == 503) {
        final snackbar = SnackBar(
            backgroundColor: Colors.red[400],
            content: Text('User Does not exist'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // result = '';

        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      final error = SnackBar(
          backgroundColor: Colors.red[400], content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  Future<void> loginwithemail(String input, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.29.238:4000/app/log-in/email-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': input,
          // Add any other data you want to send in the body
        }),
      );

      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print(responseData['token']);

        secureStorage.writeSecureData('token', responseData['token']);

        final sucessSnackbar = SnackBar(
            backgroundColor: Colors.green[400],
            content: Text(
              'OTP sent sucessfully',
              style: TextStyle(color: Colors.grey[50]),
            ));

        ScaffoldMessenger.of(context).showSnackBar(sucessSnackbar);
        context.router.popAndPush(OtpVerificationRoute());
      } else if (response.statusCode == 506) {
        final snackbar = SnackBar(
            backgroundColor: Colors.red[400],
            content: Text('User Does not exist'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // result = '';

        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      final error = SnackBar(
          backgroundColor: Colors.red[400], content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/svg/main_logo.png',
              // height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Login to Your Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Enter your registered Mobile/Email.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Form(
                child: Column(
              children: [
                TextField(
                  controller: inputcontroller,
                  cursorColor: const Color(0Xff2556B9),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 16, top: 14, bottom: 14),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      hintText: 'Enter Mobile or Email ID',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff333333).withOpacity(0.5))),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0Xff2556B9)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0))),
                      ),
                      onPressed: () {
                        if ((inputcontroller.text)
                            .contains(RegExp(r'[@.com]'))) {
                          loginwithemail(inputcontroller.text, context);
                          print("loged in with email");
                          // context.router.push(OtpVerificationRoute());
                        } else {
                          loginwithphone(inputcontroller.text, context);
                          print("loged in with phone");
                          // context.router.push(OtpVerificationRoute());
                        }
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Don’t have an Account?',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      context.router.push(const SignUpRoute());
                    },
                    child: const Text(
                      'Register Here',
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Color(0Xff2556B9)),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
