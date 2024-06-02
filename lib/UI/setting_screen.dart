import 'dart:io';

import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'SettingScreen';
  const SettingScreen({super.key});
  Widget drawerTilte(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            tileColor: Colors.grey.shade800,
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade600,
              radius: 25,
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),
            title: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 53, 53, 91),
      appBar: AppBar(
        automaticallyImplyLeading: !Platform.isAndroid ? true : false,
        backgroundColor: const Color.fromARGB(0, 53, 53, 91),
        title: const Text(
          'Setting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: drawerTilte(
              'Account',
              Icons.person,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: drawerTilte(
              'Image count',
              Icons.image,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: drawerTilte(
              'Image type',
              Icons.tune_sharp,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: drawerTilte(
              'History',
              Icons.history,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: drawerTilte(
              'Privacy',
              Icons.verified_user,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.5),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.5, color: Colors.black),
              ),
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return AlertDialog(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       title: Text(
                //         'Are you sure?',
                //         style: Theme.of(context).textTheme.titleMedium,
                //       ),
                //       content: const Text('Are you sure you want to logout?'),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: const Text('No'),
                //         ),
                //         TextButton(
                //           onPressed: () {},
                //           child: const Text('Yes'),
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
                size: 30,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
