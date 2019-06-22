import 'package:flutter/material.dart';
import './ui/cat_list.dart';

void main() async {
  runApp(new CatBoxApp());
}

class CatBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima',
        primaryColor: Colors.purple,
        accentColor: Colors.pinkAccent,
      ),
      home: new CatList(),
    );
  }
}
