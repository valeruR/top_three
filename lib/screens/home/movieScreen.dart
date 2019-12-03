import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final List movie;
  final int idx;

  MovieScreen({ Key key,
    @required this.movie,
    @required this.idx }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie[idx]["title"]),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Image.network(
              "https://image.tmdb.org/t/p/w500" + movie[idx]["poster_path"]
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Text(movie[idx]["overview"]),
          ),
          SizedBox(height: 20.0),
          RaisedButton.icon(
            color: Colors.red,
            label: Text("Choose as first movie     "),
            icon: Icon(Icons.looks_one),
            onPressed: () {
              Navigator.pop(context, 1);
            },
          ),
          RaisedButton.icon(
            color: Colors.blue,
            label: Text("Choose as second movie"),
            icon: Icon(Icons.looks_two),
            onPressed: () {
              Navigator.pop(context, 2);
            },
          ),
          RaisedButton.icon(
            color: Colors.green,
            label: Text("Choose as third movie    "),
            icon: Icon(Icons.looks_3),
            onPressed: () {
              Navigator.pop(context, 3);
            },
          ),
        ],
      ),
    );
  }
}