import 'package:assignment_project/model/localSetting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
              child: ListTile(
                title: Text('Ayam Percik'),
                subtitle: Text('I want 3 chicken'),
                leading: CircleAvatar(
                  child: Text('A'),
                  radius: 23,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '17/3/2020',
                      style: TextStyle(color: primarySwatch, fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: primarySwatch,
                      child: Text(
                        '20',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _topPageTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400])),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 110,
              child: Center(
                  child: Text(
                'CHATS',
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
            SizedBox(
              width: 100,
            ),
            Container(
              height: 35,
              width: 150,
              child: Center(
                child: TextFormField(
                  style: TextStyle(fontSize: 14),
                  controller: _chatSearchTextController,
                  decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                          color: primarySwatch, fontWeight: FontWeight.w300),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        Icons.search_sharp,
                        color: primarySwatch,
                      ),
                      enabledBorder: _borderDecoration,
                      focusedBorder: _borderDecoration),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
