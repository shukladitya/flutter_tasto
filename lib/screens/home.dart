import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tasto/functions.dart';
import 'package:tasto/screens/likedlist.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'details.dart';

int choise;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldkey = new GlobalKey<ScaffoldState>();
  bool showprogress = false;

  /////////////searching function////////////////////////
  int errormessage = 0;
  String errortext1 = 'Something went wrong.';
  String errortext2 = 'Please check your connection and try again.';
  Future fetchdata(String name, int limit) async {
    setState(() {
      showprogress = true;
    });
    try {
      response = await get('');
      decoded = jsonDecode(response.body);
      print(decoded); //testing

      taste = decoded['Similar']['Info'][0]['Name'];
      yturl = decoded['Similar']['Info'][0]['yID'];
      tastedetails = decoded['Similar']['Info'][0]['wTeaser'];
      tastewiki = decoded['Similar']['Info'][0]['wUrl'];
      choisename = decoded['Similar']['Info'][0]['Type'];
      showprogress = false;

      if (decoded['Similar']['Results'].length == 0) {
        suggcard.add(Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple[700], Color(0xFF94248E)]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'No data for $name',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 50,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Try searching in a particular category.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
        ));
      } else
        for (int i = 0; i < limit; i++) {
          suggcard.add(Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple[700], Color(0xFF94248E)]),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '${decoded['Similar']['Results'][i]['Name']}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 50,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${decoded['Similar']['Results'][i]['wTeaser']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        onPressed: () {
                          servingfunction(
                              decoded['Similar']['Results'][i]['Name'],
                              decoded['Similar']['Info'][0]['Type']);
                          print(liked_movies);
                          print(liked_games);
                          asuka.showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Taste added.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ));
                        },
                        splashColor: Colors.redAccent,
                        shape: CircleBorder(),
                        child: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                        dname: decoded['Similar']['Results'][i]
                                            ['Name'],
                                        ddetail: decoded['Similar']['Results']
                                            [i]['wTeaser'],
                                        dyturl: decoded['Similar']['Results'][i]
                                            ['yID'],
                                        dwurl: decoded['Similar']['Results'][i]
                                            ['wUrl'],
                                      )));
                        },
                        splashColor: Colors.purple,
                        shape: CircleBorder(),
                        child: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.deepPurple,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
        }
      errormessage = 0;
      errortext1 = 'Something went wrong.';
      errortext2 = 'Please check your connection and try again.';

      Navigator.pushNamed(context, 'result');
    } catch (e) {
      showprogress = false;
      print('error is -----------$e');
      errormessage = 1;
      if (decoded['Similar']['Info'][0]['Type'] == 'unknown') {
        errortext1 = 'No data found for ${name}';
        errortext2 =
            'Common causes include, wrong spelling, missing articles(the,a,an etc) which are included in the original Title.\n\nEntering exact title might fix the problem. ';
      }
    }
  }

  //////////////bigcard///////////////////////////////

  Widget cards(Color bg, String gen, int bgpic) {
    return GestureDetector(
      onTap: () {
        choise = bgpic;
        choisename = gen;
        Navigator.pushNamed(context, 'search');
      },
      child: Container(
        height: (MediaQuery.of(context).size.width / 2) - 25,
        width: (MediaQuery.of(context).size.width / 2) - 25,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/$bgpic.jpg'), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(colors: [bg, bg.withOpacity(0.1)])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${gen.toUpperCase()}S',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

///////////////////////////card small///////////////////////////////////////////////////
  Widget cardsmall(String text, FaIcon logo, int pic) {
    return GestureDetector(
      onTap: () {
        choise = pic;
        choisename = text;
        Navigator.pushNamed(context, 'search');
      },
      child: Column(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.width / 4) - 25,
            width: (MediaQuery.of(context).size.width / 4) - 25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple[700], Color(0xFF94248E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: logo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '$text',
              style: TextStyle(color: Color(0xFF767D98), fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ok1');
    getsaveddatamovies();
    getsaveddataseries();
    getsaveddatagames();
    getsaveddatabooks();
    getsaveddatapodcast();
    getsaveddatamusic();
    getsaveddataauthor();
    print(liked_books_c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldkey,
      endDrawer: new Appdrawe(),
      backgroundColor: Color(0xFF141D3C),
      body: ModalProgressHUD(
        inAsyncCall: showprogress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.width / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset('images/logo2.png'),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 14,
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      onPressed: () {
                        scaffoldkey.currentState.openEndDrawer();
                      },
                      splashColor: Colors.redAccent,
                      shape: CircleBorder(),
                      child: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Quick Search',
                        hintStyle: TextStyle(
                          color: Color(0xFF767D98),
                        ),
                        contentPadding: EdgeInsets.only(left: 22),
                        filled: true,
                        fillColor: Color(0xFF1C2754),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 50,
                  child: RaisedButton(
                    color: Color(0xFF1C2754),
                    onPressed: () async {
                      await fetchdata(name, nosugg);
                      if (errormessage != 0) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text(
                                    '$errortext1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  content: Text(
                                    '$errortext2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  backgroundColor: Color(0xFF1C2754),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ));
                      }
                    },
                    splashColor: Colors.deepPurple,
                    shape: CircleBorder(),
                    child: FaIcon(
                      FontAwesomeIcons.search,
                      color: Color(0xFF767D98),
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cards(Colors.deepPurple[800], 'movie', 16),
                        cards(Colors.deepPurple[800], 'show', 2)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cards(Colors.deepPurple[800], 'game', 7),
                        cards(Colors.deepPurple[800], 'book', 8)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: (MediaQuery.of(context).size.width / 2) - 25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF1C2754)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              cardsmall(
                                  'podcast',
                                  FaIcon(
                                    FontAwesomeIcons.microphone,
                                    color: Colors.white54,
                                    size: 45,
                                  ),
                                  100),
                              cardsmall(
                                  'music',
                                  FaIcon(
                                    FontAwesomeIcons.guitar,
                                    color: Colors.white54,
                                    size: 45,
                                  ),
                                  101),
                              cardsmall(
                                  'author',
                                  FaIcon(
                                    FontAwesomeIcons.book,
                                    color: Colors.white54,
                                    size: 45,
                                  ),
                                  102)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Appdrawe extends StatefulWidget {
  @override
  _AppdraweState createState() => _AppdraweState();
}

class _AppdraweState extends State<Appdrawe> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Taste List',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Items you like gets added here.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.deepPurple[700], Color(0xFF94248E)],
            )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_movies,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.video,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Movies',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_series,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.mask,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Shows',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_games,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.gamepad,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Games',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_books,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.book,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Books',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_podcast,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.microphone,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Podcasts',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_music,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.music,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Music',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Likedlist(
                            itemstoshowontiles: liked_author,
                          )));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.bookOpen,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'Authors',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text(
                          'Tasto App',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        content: Text(
                          'Made with  ❤  by Aditya Shukla.',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        backgroundColor: Color(0xFF1C2754),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ));
            },
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.info,
                color: Colors.deepPurple,
                size: 35,
              ),
              title: Text(
                'About',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
            ),
          )
        ],
      ),
    );
  }
}
