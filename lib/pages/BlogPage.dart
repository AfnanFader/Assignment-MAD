import 'package:assignment_project/model/blog.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:assignment_project/model/localSetting.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPage extends StatefulWidget {

  BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {


  Stream<List<BlogTrending>> blogTrending;

   @override
  void initState() {
    super.initState();
    blogTrending = DatabaseService().getBlogTrending();
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _topPageTitle(), 


            StreamBuilder<List<BlogTrending>>(
              stream: blogTrending,
              builder: (context, card){
                if (card.hasData){
                  if(card.data.isNotEmpty){
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: card.data.length,
                          itemBuilder: (context, index){
                            return _cardTest(context, card.data[index], index, card.data.length);
                          } 
                      ),
                    );
                  }
                  return Container(color: Colors.white, child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                }
                else 
                  return Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,),);
                }
              ),


          ],
        )
      ),
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
  
  Widget _cardTest(BuildContext context, BlogTrending data, int index, int currentIndex) {
    return GestureDetector(
        onTap: () async {
            if (await canLaunch(data.link)) {
              await launch(data.link);
            }
          },
        child: Card(
          child: Container(
            height: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album), //image
                  title: Text(data.title, style: TextStyle(color:Colors.pink),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.red,),
                ),
              ],
            ),
          ),
        ),
      );
  }
}