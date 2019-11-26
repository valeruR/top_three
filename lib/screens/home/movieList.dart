import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:top_three/shared/constants.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List listmovie;
  int page = 1;
  String tsearch = '';

  void fetchPost(int ppage) async {
  final response =
      await http.get('https://api.themoviedb.org/3/movie/top_rated?api_key=d245d4a8771f14361b504065ae14fe78&language=en-US&page=$ppage');
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
    return Column(
    children: [
      Container(
        width: 300.0,
          child: Column(
            children: <Widget>[
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
              ),
            );
          },
        )
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
    ]
    );
  }
}