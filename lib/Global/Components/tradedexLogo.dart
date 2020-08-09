import 'package:flutter/material.dart';

Widget getHero() {
  return Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 60.0,
      child: Image.asset('logo/tradedex_logo.png'),
    ),
  );
}
