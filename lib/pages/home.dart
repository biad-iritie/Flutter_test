import 'package:flutter/material.dart';

import '../services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as WorldTime;
    print(data.isDayTime);

    String bgImage = data.isDayTime ? 'day.jpeg' : 'night.jpeg';
    Color bgColor = data.isDayTime
        ? const Color.fromARGB(255, 241, 235, 199)
        : const Color.fromARGB(255, 49, 49, 51);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(children: <Widget>[
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.black87,
                ),
                label: Text(
                  "Edit Location",
                  style: TextStyle(color: Colors.black87),
                )),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data.location,
                  style: TextStyle(
                      fontSize: 28.0, letterSpacing: 2.0, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              data.time,
              style: TextStyle(fontSize: 66, color: Colors.black),
            )
          ]),
        ),
      )),
    );
  }
}
