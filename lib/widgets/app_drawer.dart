import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/screens/movies_overview.dart';

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
            leading: Icon(Icons.movie),
            title: Text('All Movies'),
            onTap: () {
              Navigator.of(context).pushNamed(MoviesOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LogOut'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
