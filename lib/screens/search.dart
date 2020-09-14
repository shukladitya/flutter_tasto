import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tasto/screens/details.dart';
import 'home.dart';
import 'package:tasto/functions.dart';
import 'package:asuka/asuka.dart' as asuka;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int errormessage = 0;
  bool showprogress2 = false;
  String errortext1 = 'Something went wrong.';
  String errortext2 = 'Please check your connection and try again.';
  Future fetchdata(String name, int limit, String type) async {
    setState(() {
      showprogress2 = true;
    });
    try {
      response = await get('');
      decoded = jsonDecode(response.body);
      print(decoded); //testing

      taste = decoded['Similar']['Info'][0]['Name'];
      yturl = decoded['Similar']['Info'][0]['yID'];
      tastedetails = decoded['Similar']['Info'][0]['wTeaser'];
      tastewiki = decoded['Similar']['Info'][0]['wUrl'];
      showprogress2 = false;
      if (decoded['Similar']['Results'].length == 0 &&
          decoded['Similar']['Info'][0]['Type'] != 'unknown') {
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
                  'No similar taste found',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 50,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Use \"Quick Search\" on home, to search in all categories or try something else',
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
                              decoded['Similar']['Results'][i]['Name'], type);
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
                      margin: EdgeInsets.only(top: 10),
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
      showprogress2 = false;
      errortext1 = 'Something went wrong.';
      errortext2 = 'Please check your connection and try again.';
      print('error is -----------$e');
      errormessage = 1;
      if (decoded['Similar']['Info'][0]['Type'] == 'unknown') {
        print(
            'This is working..............${decoded['Similar']['Info'][0]['Type']}');
        errortext1 = 'No data found for ${name}';
        errortext2 =
            'Common causes include, wrong spelling, missing articles(the,a,an etc) which are included in the original Title.\n\nEntering exact title might fix the problem. ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showprogress2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF141D3C),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/$choise.jpg'), fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.deepPurple,
                    Colors.deepPurple.withOpacity(0.1)
                  ])),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${choisename.toUpperCase()}S',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 45,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Your Taste :',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter ${choisename.toLowerCase()}',
                        hintStyle:
                            TextStyle(color: Color(0xFF767D98), fontSize: 25),
                        contentPadding:
                            EdgeInsets.only(left: 22, top: 35, right: 12),
                        filled: true,
                        fillColor: Color(0xFF1C2754),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide.none),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: RaisedButton(
                      color: Color(0xFF1C2754),
                      onPressed: () async {
                        await fetchdata(name, nosugg, choisename);
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Suggestions :',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Slider(
              value: nosugg.toDouble(),
              onChanged: (value) {
                setState(() {
                  nosugg = value.toInt();
                });
              },
              divisions: 4,
              label: '$nosugg',
              max: 50,
              min: 10,
              activeColor: Color(0xFF94248E),
              inactiveColor: Colors.deepPurple[800],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            )
          ],
        ),
      ),
    );
  }
}
