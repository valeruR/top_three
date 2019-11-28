import 'package:flutter/material.dart';
import 'package:top_three/models/movie.dart';
import 'package:top_three/models/top.dart';
import 'package:top_three/screens/home/movieList.dart';
import 'package:top_three/screens/home/topList.dart';
// import 'package:tuto_ninja/screens/home/brew_list.dart';
// import 'package:tuto_ninja/screens/home/settings_form.dart';
import 'package:top_three/services/auth.dart';
import 'package:top_three/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    /* void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    } */

    return StreamProvider<List<Top>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Top Three'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log out'),
              onPressed: () async {
                 await _auth.signOut();
              },
            ),
             FlatButton.icon(
              icon: Icon(Icons.library_add),
              label: Text('Your List'),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => MovieList(),
                ));
              },
            ),
          ],
        ),
        body: Container(
          child: TopList(),
        ),
      ),
    );
  }
}