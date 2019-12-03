import 'package:flutter/material.dart';

@immutable
class Message {
  final String title = '';
  final String body = '';

  const Message({
    @required title,
    @required body
  });
}