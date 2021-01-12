import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment_project/model/localSetting.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chatSearchTextController =
      TextEditingController();

  final _borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(17.5),
      borderSide: BorderSide(color: primarySwatch, width: 2));

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _topPageTitle(),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 75,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1))),
                child: Consumer<UserNotifier>(
                  builder: (context, notifier, widget) => Center(
                    child: Text(notifier.getUserUID),
                  ),
                ))
          ],
        ));
  }

  Widget _topPageTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400])),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 110,
              child: Center(
                  child: Text(
                'BROWSE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 19),
              )),
              decoration: BoxDecoration(
                  color: primarySwatch,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.5),
                      bottomRight: Radius.circular(17.5))),
            ),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Container(
                  height: 35,
                  width: 300,
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(fontSize: 14),
                      controller: _chatSearchTextController,
                      decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: TextStyle(
                              color: primarySwatch,
                              fontWeight: FontWeight.w300),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Icon(
                            Icons.search_sharp,
                            color: primarySwatch,
                          ),
                          enabledBorder: _borderDecoration,
                          focusedBorder: _borderDecoration),
                    ),
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
