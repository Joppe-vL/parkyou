import 'package:flutter/material.dart';

class NavigationBara extends StatelessWidget {
  final String destination;

  const NavigationBara({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Color.fromARGB(255, 255, 230, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.ballot_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/parkspotsscreen');
            },
            color: destination == '/parkspotsscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.local_parking),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/releaseparkscreen');
            },
            color: destination == '/releaseparkscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.map_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/mapscreen');
            },
            color: destination == '/mapscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.directions_car_filled_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/vehiclescreen');
            },
            color: destination == '/vehiclescreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/accountscreen');
            },
            color: destination == '/accountscreen' ? Colors.white : null,
          ),
        ],
      ),
    );
  }
}
