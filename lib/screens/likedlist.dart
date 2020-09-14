import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Likedlist extends StatefulWidget {
  List itemstoshowontiles;
  Likedlist({this.itemstoshowontiles});
  @override
  _LikedlistState createState() => _LikedlistState();
}

class _LikedlistState extends State<Likedlist> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.itemstoshowontiles);
    if ((widget.itemstoshowontiles).length == 0)
      tilesofwheel.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Color(0xFF1C2754),
          height: 100,
          width: 500,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'No item added in this category, Explore your taste and add them here.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          )),
        ),
      ));
    for (String items in widget.itemstoshowontiles) {
      tilesofwheel.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Color(0xFF1C2754),
          height: 100,
          width: 500,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              items,
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          )),
        ),
      ));
    }
  }

  List<Widget> tilesofwheel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141D3C),
      body: ListWheelScrollView(itemExtent: 200, children: tilesofwheel),
    );
  }
}
