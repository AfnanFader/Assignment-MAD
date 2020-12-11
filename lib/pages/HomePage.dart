import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<UserNotifier>(
        builder: (context, notifier, widget) => Center(child: Text(notifier.getUserUID),),
      )
    );
  }
}