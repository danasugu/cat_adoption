import 'dart:async';
import 'package:cat_adoption/models/cat.dart';
import 'package:cat_adoption/services/api.dart';
import 'package:flutter/material.dart';
import './../ui/cat_details/details_page.dart';
import '../utils/routes.dart';


class CatList extends StatefulWidget {
  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  List<Cat> _cats = [];
  CatApi _api;
  NetworkImage _profileImage;


  @override
  void initState() {
    super.initState();
//    _loadCats();
    _loadFromFirebase();
    _reloadCats();
  }

  _loadFromFirebase()async {
    final api = await CatApi.signInWithGoogle();
//   firebase added
    final cats = await api.getAllCats();
//
    setState(() {
     _api = api;
     _cats = cats;
     _profileImage = new NetworkImage(api.firebaseUser.photoUrl);


    });

  }

  _reloadCats() async {
    if (_api != null) {
  final cats = await _api.getAllCats();
      setState(() {
        _cats = cats;

  });
    }
  }


//  jason needed
//  _loadCats() async {
//    String fileData =
//        await DefaultAssetBundle.of(context).loadString("assets/cats.json");
//    setState(() {
//      _cats = CatApi.allCatsFromJson(fileData);
//    });
//  }

  _navigateToCatDetails(Cat cat, Object avatarTag) {
    Navigator.of(context).push(
      new FadePageRoute(
        builder: (c) {
          return new CatDetailsPage(cat, avatarTag: avatarTag);
        },
        settings: new RouteSettings(),
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Adopta o pisica',
        style: TextStyle(
            color: Colors.white,
          fontWeight: FontWeight.bold, fontSize: 37.0,
          fontFamily: 'Raleway',),
      ),
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0.0),
      child: new Column(
        children: <Widget>[_getAppTitleWidget(), _getListViewWidget()],
      ),
    );
  }

    Widget _buildCatItem(BuildContext context, int index) {
    Cat cat = _cats[index];

    return new Container(
//      color: Colors.greenAccent,
      margin: const EdgeInsets.all(11.0),
      child: new Card (color: Colors.pink,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () => _navigateToCatDetails(cat, index),
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(cat.avatarUrl),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cat.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                    color: Colors.white
                  ),
                  ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cat.description,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,

                  ),
                ),
              ),

              isThreeLine: true,
              dense: false,
            )
          ],
        ),
      ),
    );
    }

  Future<Null> refresh() {
    _reloadCats();
//    _loadCats();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return new Flexible(
        child: new RefreshIndicator(
      onRefresh: refresh,
          child: new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _cats.length,
            itemBuilder: _buildCatItem,
          ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: _buildBody(),
      floatingActionButton: new FloatingActionButton(
          onPressed: (){},
        tooltip: _api != null ? 'Signed-in: ' + _api.firebaseUser.displayName : 'Not Signed-in',
        backgroundColor: Colors.blue,
        child: new CircleAvatar(
          backgroundImage: _profileImage,
          radius: 50.0,
        ),
      ),
    );
  }
}


