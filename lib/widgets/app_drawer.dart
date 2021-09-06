import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:moives_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello'),
            automaticallyImplyLeading: false,
          ),
         
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
             Navigator.of(context).popAndPushNamed(SplashScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
