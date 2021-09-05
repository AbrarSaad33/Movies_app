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
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.movie),
          //   title: Text('All Movies'),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(MoviesOverviewScreen.routeName);
             
          //   },
          // ),
          //  Divider(),
          //  ListTile(
          //   leading: Icon(Icons.rate_review_rounded),
          //   title: Text('Top Rated'),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(TopRatedMovieScreen.routeName);
             
          //   },
          // ),
          // Divider(),
          //     ListTile(
                
          //   leading: Icon(Icons.upcoming),
          //   title: Text('Upcoming'),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(UpComingMovieScreen.routeName);
          //   },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('LogOut'),
            onTap: () {
             // Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed(Start.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
