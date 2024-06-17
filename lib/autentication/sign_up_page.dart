import 'dart:convert';

import 'package:absolutemen_app/autentication/provider/authentication_provider.dart';
import 'package:absolutemen_app/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> signupformkey = GlobalKey<ScaffoldState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> register(String fname, String lname, String email, String phone,
      BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.29.238:4000/app/sign-up'),
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

        final sucessSnackbar = SnackBar(
            backgroundColor: Colors.green[400],
            content: Text(
              'User registered successfully',
              style: TextStyle(color: Colors.grey[50]),
            ));

        ScaffoldMessenger.of(context).showSnackBar(sucessSnackbar);
        context.router.popAndPush(LoginRoute());
      } else if (response.statusCode == 406) {
        final snackbar =
            SnackBar(content: Text('This user is already in use!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // result = '';

        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      final error = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: signupformkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'REGISTER',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: fnameController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z]'),
                  )
                ],
                cursorColor: const Color(0Xff2556B9),
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 14, bottom: 14),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: 'First Name',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333).withOpacity(0.5))),
              ),
              const SizedBox(
                height: 9,
              ),
              TextField(
                controller: lnameController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                cursorColor: const Color(0Xff2556B9),
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 14, bottom: 14),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333).withOpacity(0.5))),
              ),
              const SizedBox(
                height: 9,
              ),
              TextField(
                controller: phoneController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.phone,
                cursorColor: const Color(0Xff2556B9),
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 14, bottom: 14),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: 'Mobile Number',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333).withOpacity(0.5))),
              ),
              const SizedBox(
                height: 9,
              ),
              TextField(
                controller: emailController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.@]')),
                ],
                cursorColor: const Color(0Xff2556B9),
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 14, bottom: 14),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: 'Email ID',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333).withOpacity(0.5))),
              ),
              const SizedBox(
                height: 9,
              ),
              // TextField(
              //   cursorColor: const Color(0Xff2556B9),
              //   decoration: InputDecoration(
              //       focusedBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey.shade400,
              //         ),
              //       ),
              //       contentPadding:
              //           const EdgeInsets.only(left: 16, top: 14, bottom: 14),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey.shade400,
              //         ),
              //       ),
              //       hintText: 'Password',
              //       hintStyle: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           color: const Color(0xff333333).withOpacity(0.5))),
              // ),
              // const SizedBox(
              //   height: 9,
              // ),
              // TextField(
              //   cursorColor: const Color(0Xff2556B9),
              //   decoration: InputDecoration(
              //       focusedBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey.shade400,
              //         ),
              //       ),
              //       contentPadding:
              //           const EdgeInsets.only(left: 16, top: 14, bottom: 14),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(5)),
              //         borderSide: BorderSide(
              //           color: Colors.grey.shade400,
              //         ),
              //       ),
              //       hintText: 'Confirm Password',
              //       hintStyle: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           color: const Color(0xff333333).withOpacity(0.5))),
              // ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        vertical: 14,
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0Xff2556B9)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0))),
                    ),
                    onPressed: () {
                      register(fnameController.text, lnameController.text,
                          emailController.text, phoneController.text, context);

                      // if (authprovider.result.isNotEmpty) {
                      //   context.router.push(LoginRoute());
                      // }
                    },
                    child: const Text(
                      'Continue',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Already have an Account?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    context.router.push(const LoginRoute());
                  },
                  child: const Text(
                    'Login Here',
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: Color(0Xff2556B9)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
