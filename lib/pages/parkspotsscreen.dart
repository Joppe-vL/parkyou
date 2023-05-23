import 'package:flutter/material.dart';

class ParkSpotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0d3ff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Image(
              image: AssetImage("assets/images/Bigger.png"),
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              "Park Spots",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your park spots:",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/yourparkspot');
                    },
                    child: ListTile(
                      tileColor: Color(0xffffffff),
                      title: Text(
                        "Location:",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        "The_Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      selected: false,
                      selectedTileColor: Color(0x42000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0x7f9e9e9e), width: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Reserved park spots:",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              shrinkWrap: false,
              physics: ScrollPhysics(),
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/yourreservedparkspot');
                    },
                    child: ListTile(
                      tileColor: Color(0xffffffff),
                      title: Text(
                        "Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        "The_Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      selected: false,
                      selectedTileColor: Color(0x42000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0x809e9e9e), width: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
