import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasto/functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:asuka/asuka.dart' as asuka;

class Details extends StatefulWidget {
  var dyturl;
  var dname;
  var ddetail;
  var dwurl;

  Details({this.dname, this.ddetail, this.dyturl, this.dwurl});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  YoutubePlayerController controller;
  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: '${widget.dyturl}',
      flags: YoutubePlayerFlags(autoPlay: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Color(0xFF141D3C),
        body: YoutubePlayerBuilder(
          builder: (context, player) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  player,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${widget.dname}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 45,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 3),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            '${widget.ddetail}',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              servingfunction(widget.dname, choisename);
                              print(liked_movies);
                              print(liked_games);
                              print(liked_series);
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
                          height: 60,
                          child: RaisedButton(
                            onPressed: () async {
                              String url = widget.dwurl;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            splashColor: Colors.purple,
                            shape: CircleBorder(),
                            child: FaIcon(
                              FontAwesomeIcons.wikipediaW,
                              color: Colors.deepPurple,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          player: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          ),
        ));
  }
}
