import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasto/functions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'details.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  YoutubePlayerController controller;
  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: '$yturl',
      flags: YoutubePlayerFlags(autoPlay: false),
    );
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    suggcard.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141D3C),
      body: YoutubePlayerBuilder(
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Color(0xFF1C2754),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 2 * MediaQuery.of(context).size.width / 3,
                            child: player),
                        Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 14,
                              margin: EdgeInsets.only(top: 10),
                              child: RaisedButton(
                                onPressed: () {
                                  servingfunction(taste, choisename);
                                  print(liked_movies);
                                  print(liked_games);
                                  asuka.showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Taste added.',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
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
                              height: MediaQuery.of(context).size.height / 14,
                              margin: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                dname: taste,
                                                ddetail: tastedetails,
                                                dyturl: yturl,
                                                dwurl: tastewiki,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        '$taste',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Similar taste :',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CarouselSlider(
                    items: suggcard,
                    options: CarouselOptions(
                      height: (2 * MediaQuery.of(context).size.height / 3) - 80,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
              )
            ],
          );
        },
        player: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
