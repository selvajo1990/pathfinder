import 'package:flutter/material.dart';
import 'package:pathfinder/models/changenotifier.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  final String data;
  const SecondPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CountingNumber(),
      child: Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Second Page'),
        ),
        body: Center(
          child: Column(
            children: [
              Consumer<CountingNumber>(
                builder: (context, message, child) {
                  return Text(message.message);
                },
              ),
              SizedBox(height: 10.0),
              Consumer<CountingNumber>(
                builder: (context, message, child) {
                  return Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          message.testMessage();
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.ac_unit_rounded),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
