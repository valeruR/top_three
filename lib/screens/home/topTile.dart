import 'package:flutter/material.dart';
import 'package:top_three/models/top.dart';

class TopTile extends StatelessWidget {

  final Top top;
  TopTile({ this.top });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(top.one),
              ),
              Container(
                child: Text(top.two),
              ),
              Container(
                child: Text(top.three),
              ),
              RaisedButton.icon(
                label: Text(''),
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
            ],
          ),
        )
    );
  }
}