import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopupMenuItem(
            child: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
        PopupMenuItem(
            child: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.w600),
        )),
      ],
    );
  }
}
