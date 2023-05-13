import 'package:flutter/material.dart';

class NavigationBara extends StatelessWidget {
  final String destination;

  const NavigationBara({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.pageview),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/removeparkscreen');
            },
            color: destination == '/removeparkscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.pageview),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/releaseparkscreen');
            },
            color: destination == '/releaseparkscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.pageview),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/mapscreen');
            },
            color: destination == '/mapscreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.pageview),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/vehiclescreen');
            },
            color: destination == '/vehiclescreen' ? Colors.white : null,
          ),
          IconButton(
            icon: Icon(Icons.pageview),
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
