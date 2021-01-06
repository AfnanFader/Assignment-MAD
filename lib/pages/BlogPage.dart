import 'package:flutter/material.dart';
import 'package:assignment_project/model/localSetting.dart';

class BlogPage extends StatefulWidget {

  BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _topPageTitle(), _cardTest()
        ],
      )
    );
    
  }

  Widget _topPageTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
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
              child: Center(child: Text('BLOG', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19),)),
              decoration: BoxDecoration(
                color: primarySwatch,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(17.5),
                  bottomRight: Radius.circular(17.5)
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _cardTest() {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}