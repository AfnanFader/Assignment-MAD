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

class _BlogPageState extends State<BlogPage> with SingleTickerProviderStateMixin {

  TabController _controller;
  Stream<List<BlogTrending>> blogTrending;

   @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex:0, length: 3, vsync: this);
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
            //Tabs
            _tabs(context),


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
  


    Widget _tabs(BuildContext context) {
    return Expanded(
        flex: 15,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              TabBar(
                controller: _controller,
                indicatorColor: primarySwatch,
                labelColor: primarySwatch,
                unselectedLabelColor: Colors.grey[500],
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: 'Trending',),
                  Tab(text: 'Cats',),
                  Tab(text: 'Dogs',)
                ],
              ),

              Expanded(
                flex: 1,
                  child: TabBarView(
                    controller: _controller,
                    children: [
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
                      
                      Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('U got nothin boi'),
                      )
                    ),
                      Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('U got nothin boi'),
                      )
                    ),
                    ],
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
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  leading: Image.network(
                    data.image,
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null)
                        return child;
                      return CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                          : null,
                        );
                    }
                  ),

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