import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_three/models/user.dart';
import 'package:top_three/screens/authentificate/authentificate.dart';
import 'package:top_three/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print (user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}