import 'package:auto_route/auto_route.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'CaptionThis',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('res/images/confluences.jpg'))),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('My Groups'),
            onTap: () => {},
            textColor: Colors.black26,
            iconColor: Colors.black26,
          ),
          ListTile(
            leading: const Icon(Icons.account_box_rounded),
            title: const Text('My Account'),
            onTap: () => {},
            textColor: Colors.black26,
            iconColor: Colors.black26,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {},
            textColor: Colors.black26,
            iconColor: Colors.black26,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              var storage = const FlutterSecureStorage();
              storage.delete(key: "jwt");
              context.router.replaceAll([LoginRoute()]);
            },
          ),
        ],
      ),
    );
  }
}
