import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'Auth_screen.dart';
import 'movies_overview.dart';

class Start extends StatelessWidget {
  static const routeName = '/start';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/start.jpg'),
                     
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Movie App",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: Text(
                      "To Be Interested .......",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        final auth = Provider.of<Auth>(context, listen: false);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return auth.isAuth
                                ? MoviesOverviewScreen()
                                : FutureBuilder(
                                    future: auth.tryAutoLogin(),
                                    builder: (ctx, authResultSnapShot) =>
                                        authResultSnapShot.connectionState ==
                                                ConnectionState.waiting
                                            ? Text('Loading...')
                                            : AuthScreen());
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25, top: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.yellow,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "START ",
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        color: Colors.black,
                                      ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}