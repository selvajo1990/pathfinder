import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pathfinder/models/firebase_auth.dart';
import 'dart:convert';
import 'package:pathfinder/utils/services/database.dart';
import 'package:provider/provider.dart';

class CheckConnection extends StatefulWidget {
  CheckConnection({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _CheckConnectionState createState() => _CheckConnectionState();
}

class _CheckConnectionState extends State<CheckConnection> {
  // void getCountry(country) {
  //   String countryUrl = 'https://restcountries.eu/rest/v2/name/$country';
  //   http
  //       .get(Uri.parse(countryUrl))
  //       .then((response) => jsonDecode(response.body)[0]['name'])
  //       .then((decode) => print(decode))
  //       .catchError((onError) => print(onError));
  //   print('came to last line');
  // }

  Future<String> getCountry(country) async {
    String countryUrl = 'https://restcountries.eu/rest/v2/name/$country';
    try {
      http.Response response = await http.get(Uri.parse(countryUrl));
      Object decoded = jsonDecode(response.body)[0]['name'];
      return decoded;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userInfo = Provider.of<UserInformation>(context);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<UserInformation>(
              builder: (context, userInfo, child) {
                return Text(userInfo != null
                    ? userInfo.uid
                    : CircularProgressIndicator());
              },
            ),
            // Text(userInfo != null ? userInfo.uid : 'no user'),
            Divider(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
              ),
              onPressed: () async {
                var country = await getCountry('canada');
                print(country);
              },
              child: Text(
                'Get Country',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
              ),
              onPressed: () async {
                await CheckUserAccess()
                    .signWithFirebase('selva.t@gmail.com', '123456');
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
              ),
              onPressed: () async {
                dynamic result = await CheckUserAccess().signOut();
                print(result);
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Divider(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.greenAccent[700]),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/second', arguments: 'Change Notifier');
              },
              child: Text(
                'Change Notifier',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
