import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/pages/EditProfilePage.dart';
import 'package:assignment_project/pages/NewPostPage.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _topPart(context),
        _bottomPart(context),
      ],
    );
  }

  Widget _bottomPart(BuildContext context) {
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
                  Tab(text: 'POST',),
                  Tab(text: 'WISHLIST',)
                ],
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('U got nothin boi'),
                      )
                    ),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            color: Colors.purple,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget _topPart(BuildContext context) {
    return Expanded(
        flex: 15,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Consumer<UserNotifier>(
                builder: (context, notifier, widget) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:EdgeInsets.only(top: 50),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: primarySwatch,
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          child: Text('${notifier.getUserData.username[0].toUpperCase()}',style: TextStyle(color: primarySwatch, fontSize: 35),),
                        ),
                      ),
                    ),
                    Padding(
                       padding:EdgeInsets.only(top: 10),
                      child: Text('${notifier.getUserData.username}', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                       padding:EdgeInsets.only(top: 3),
                      child: Text('${notifier.getUserData.email}',style: TextStyle(color: Colors.black, fontSize: 12,)),
                    ),
                    Padding(
                       padding:EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            elevation: 2,
                            color: Colors.white,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditProfilePage())),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: primarySwatch, width: 1)
                            ),
                            child: Container(
                              width: 90,
                              child: Center(child: Text('Edit Profile', style: TextStyle(color: primarySwatch, fontSize: 13),)),
                            ),
                          ),
                          SizedBox(width: 10,),
                          RaisedButton(
                            elevation: 2,
                            color: primarySwatch,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) => NewPostPage())),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: primarySwatch,width: 1)
                            ),
                            child: Container(
                              width: 90,
                              child: Center(child: Text('New Post', style: TextStyle(color: Colors.white, fontSize: 13),)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 15,
                child: Container(
                  height: 35,
                  width: 120,
                  child: Center(child: Text('PROFILE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19),)),
                  decoration: BoxDecoration(
                    color: primarySwatch,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.5),
                      bottomRight: Radius.circular(17.5)
                    )
                  ),
                ),
              ),
              Positioned(
                top: 13,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.logout, color: primarySwatch, size: 26,),
                  //onPressed: () => AuthService().signOut(),
                  onPressed: (){
                    final provider =
                    Provider.of<UserNotifier>(context, listen: false);
                    provider.logout();
                    AuthService().signOut();
                  },
                ),
              )
            ],
          ),
        ),
      );
  }
}