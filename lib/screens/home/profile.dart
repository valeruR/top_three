import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_three/models/user.dart';
import 'package:top_three/screens/home/imagecapture.dart';
import 'package:top_three/screens/home/movieList.dart';
import 'package:top_three/services/database.dart';
import 'package:top_three/shared/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                (userData.picture.isNotEmpty) ? Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                      "https://i.imgur.com/BoN9kdC.png")
                    )
                  ),
                ) : RaisedButton.icon(
                  label: Text('Add a picture'),
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () async{
                    await Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => ImageCapture(),
                  ));
                  },
                ),
                Container(
                  height: 50,
                  color: Colors.red[100],
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(userData.one,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.red[100],
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(userData.two,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.red[100],
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(userData.three,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Update your Top'),
                  onPressed: () async {
                    await Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => MovieList(currmovie1: userData.one, currmovie2: userData.two,
                      currmovie3: userData.three),
                  ));
                  },
                )
              ],
            )
          );
        } else {
          return MovieList(currmovie1: '', currmovie2: '', currmovie3: '');
        }
      },
    );
  }
}