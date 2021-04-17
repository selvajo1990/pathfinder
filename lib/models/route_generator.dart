import 'package:flutter/material.dart';
import 'package:pathfinder/screens/check_connection.dart';
import 'package:pathfinder/screens/error_page.dart';
import 'package:pathfinder/screens/secondpage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => CheckConnection(
            title: 'Firebase Connection',
          ),
        );
      case '/second':
        if (arguments is String) {
          return MaterialPageRoute(
            builder: (_) => SecondPage(
              data: arguments,
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => ErrorPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(),
        );
    }
  }
}
