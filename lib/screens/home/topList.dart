import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_three/models/top.dart';
import 'package:top_three/screens/home/topTile.dart';

class TopList extends StatefulWidget {
  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  @override
  Widget build(BuildContext context) {

    final tops = Provider.of<List<Top>>(context) ?? [];

    return ListView.builder(
      itemCount: tops.length,
      itemBuilder: (context, index) {
        return TopTile(top: tops[index]);
      },
    );
  }
}