import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDetails extends StatelessWidget {
  const MenuDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 36, top: 36),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsetsDirectional.zero,
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsetsDirectional.zero,
                  leading: Icon(
                    Icons.approval,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Manage Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsetsDirectional.zero,
                  leading: Icon(
                    FontAwesomeIcons.bagShopping,
                    color: Colors.black,
                  ),
                  title: Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsetsDirectional.zero,
                  leading: Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.black,
                  ),
                  title: Text(
                    'My Wishlist',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsetsDirectional.zero,
                  leading: Icon(
                    Icons.fire_truck_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Column(
              children: [DropdownButton(items: [], onChanged: (_) {})],
            ),
          )
        ],
      ),
    );
  }
}
