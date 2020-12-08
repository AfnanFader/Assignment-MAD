

import 'package:assignment_project/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: FloatingActionButton(
          child: Text('GTFO'),
          onPressed: () => AuthService().signOut(),
        ),
      )
    );
  }
}