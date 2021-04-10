import 'package:flutter/material.dart';
import 'package:pathfinder/models/firebase_auth.dart';
import 'package:pathfinder/screens/check_connection.dart';
import 'package:pathfinder/utils/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserInformation>(
      create: (_) => CheckUserAccess().userState,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CheckConnection(
          title: 'Firebase Connection',
        ),
      ),
    );
  }
}
