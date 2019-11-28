import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:top_three/models/user.dart';
import 'package:top_three/services/database.dart';

import 'movieScreen.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List listmovie;
  int page = 1;
  String tsearch = '';
  String currmovie1 = '';
  String currmovie2 = '';
  String currmovie3 = '';

  void fetchPost(int ppage) async {
  final response =
      await http.get('https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=d245d4a8771f14361b504065ae14fe78&language=en-US&page=$ppage');
  Map data = json.decode(response.body);
  setState(() => listmovie = data["results"]);
}

void searchMovie() async {
  setState(() {
    page = 1;
  });
  final res = 
  await http.get('https://api.themoviedb.org/3/search/movie?api_key=d245d4a8771f14361b504065ae14fe78&query=$tsearch&page=1&include_adult=false');
  Map data = json.decode(res.body);
  setState(() => listmovie = data["results"]);
}

  @override
  void initState() {
    super.initState();
    fetchPost(page);
  }

  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return Scaffold( 
    appBar: AppBar(
      title: Text('Top Three'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
    ),
    body: Column(
    children: [
      Container(
        width: 300.0,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: (val) {
                  setState(() {
                    tsearch = val; 
                  });
                },
              ),
              RaisedButton(
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {searchMovie();},
              )
            ],
          ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: listmovie == null ? 0 : listmovie.length,
          itemBuilder: (BuildContext context, int idx) {
            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage("https://image.tmdb.org/t/p/w500" + listmovie[idx]["poster_path"]),
                ),
                title: Text("${listmovie[idx]["title"]}"),
                subtitle: ((listmovie[idx]["overview"]).length > 25) ? Text(("${listmovie[idx]["overview"]}").substring(0, 25)) : Text("${listmovie[idx]["overview"]}"),
                onTap: () async {
                  var res = await Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => MovieScreen(movie: listmovie, idx: idx,)
                  ));
                  switch(res) {
                    case 1:
                      setState(() {
                        currmovie1 = listmovie[idx]["title"];
                      });
                      print("movie1: " + currmovie1);
                      break;
                    case 2:
                      setState(() {
                        currmovie2 = listmovie[idx]["title"];
                      });
                      print("movie2: " + currmovie2);
                      break;
                    case 3:
                      setState(() {
                        currmovie3 = listmovie[idx]["title"];
                      });
                      print("movie3: " + currmovie3);
                      break;
                  }
                },
              ),
            );
          },
        )
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Prev'),
            onPressed: () {
              setState(() {
                if (page > 1)
                  page--;
              });
              fetchPost(page);
            }
          ),
          RaisedButton(
            child: Text('Next'),
            onPressed: () {
              setState(() {
                page++;
              });
              fetchPost(page);
            }
          ),
          (currmovie1.isNotEmpty && currmovie2.isNotEmpty && currmovie3.isNotEmpty) ? RaisedButton(
            child: Text('Create'),
            onPressed: () async {
              await DatabaseService(uid: user.uid).updateUserData(currmovie1, currmovie2, currmovie3);
            }
          ) : SizedBox(),
        ],
      ),
    ]
    ),
    );
  }
}