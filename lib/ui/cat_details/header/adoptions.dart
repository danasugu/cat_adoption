import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';



void main() {
  runApp(new MaterialApp(
    home: new Adoptions(),
  ));
}

class Adoptions extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Adoptions> {

  void _showUrl() {
    _launch('http://danasugu.com/');
  }

  void _showEmail() {
    _launch('mailto:dana.sugu@gmail.com');
  }

  void _showTelephone() {
    _launch('tel:+40720642198');
  }

  void _showSms() {
    _launch('sms:+40720642198');
  }

  void _launch(String urlString) async {
    if(await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch Url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pinkAccent,
        title: new Text('Adopta o pisica'),
      ),
      body: new Container(color: Colors.pinkAccent ,
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  color: Colors.pink, textColor: Colors.white,elevation: 11,
                  onPressed: _showUrl, child: new Text('website'),),
                new RaisedButton(
                  color: Colors.pink, textColor: Colors.white,elevation: 11,
                  onPressed: _showEmail, child: new Text('email'),),
                new RaisedButton(
                  color: Colors.pink, textColor: Colors.white,elevation: 11,
                  onPressed: _showSms, child: new Text('sms'),),
                new RaisedButton(
                  color: Colors.pink, textColor: Colors.white,elevation: 11,
                  onPressed: _showTelephone, child: new Text('telefon'),),

              ],
            ),
          )
      ),
    );
  }
}










//import 'package:flutter/material.dart';
//
//class Adoptions extends StatefulWidget {
//  @override
//  _AdoptionsState createState() => _AdoptionsState();
//}
//
//class _AdoptionsState extends State<Adoptions> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: Colors.pinkAccent,
//        title: Text("Adoptii Pisici"),
//      ),
//      body: new Center(
//        child: Text("Adoptions"),
//      ),
//    );
//  }
//}