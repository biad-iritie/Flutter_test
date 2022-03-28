import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  final String location; //location name for the UI
  late String time; // time in that location
  final String flag; // url to an asset icon
  final String url; // location url for api endpoint
  late bool isDayTime; // true or false if daytime or not
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      final Uri req_url = Uri.http('worldtimeapi.org', '/api/timezone/$url');
      http.Response res = await http.get(req_url);
      Map data = jsonDecode(res.body);
      //http.Response response = await http.get(url);
      //print(response);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
