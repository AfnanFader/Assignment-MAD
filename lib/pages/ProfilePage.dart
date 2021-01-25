import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/pet.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/pages/EditProfilePage.dart';
import 'package:assignment_project/pages/NewPostPage.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  Stream<List<Pet>> petPost;
  Stream<List<Pet>> petLiked;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    UserNotifier notifier = Provider.of<UserNotifier>(context, listen: false);
    petPost = DatabaseService().getPetPost(notifier.getUserUID);
    petLiked = DatabaseService().getPetLiked(notifier.getUserUID);
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
                Tab(
                  text: 'POST',
                ),
                Tab(
                  text: 'WISHLIST',
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: _controller,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<List<Pet>>(
                        stream: petPost,
                        builder: (context, card) {
                          if (card.hasData) {
                            if (card.data.isNotEmpty) {
                              return Container(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: card.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () => {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             PetDetailPage(
                                            //                 pet: card
                                            //                     .data[index])))
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: primarySwatch,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${card.data[index].images[0]}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              '${card.data[index].petName}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              card.data[index]
                                                                  .dateCreated
                                                                  .toDate()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      child: Row(children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child:
                                                                    Image.asset(
                                                                  (card.data[index]
                                                                          .gender)
                                                                      ? "assets/image/Male_Icon.png"
                                                                      : "assets/image/Female_Icon.png",
                                                                  width: 14.0,
                                                                  height: 14.0,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: (card
                                                                        .data[
                                                                            index]
                                                                        .gender)
                                                                    ? " Male"
                                                                    : " Female",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ])),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0,
                                                              vertical: 5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/image/Cat_Icon.png",
                                                                      width:
                                                                          16.0,
                                                                      height:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        " ${card.data[index].type}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              card.data[index]
                                                                  .location,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              )),
                                        ),
                                      ));
                                    }),
                              );
                            }
                            return Container(
                                color: Colors.white,
                                child: Center(child: Text('No post yet.')));
                          } else
                            return Center(
                              child: Text('No post yet.'),
                            );
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<List<Pet>>(
                        stream: petLiked,
                        builder: (context, card) {
                          if (card.hasData) {
                            if (card.data.isNotEmpty) {
                              return Container(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: card.data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () => {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             PetDetailPage(
                                            //                 pet: card
                                            //                     .data[index])))
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: primarySwatch,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            '${card.data[index].images[0]}'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              '${card.data[index].petName}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              card.data[index]
                                                                  .dateCreated
                                                                  .toDate()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      child: Row(children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child:
                                                                    Image.asset(
                                                                  (card.data[index]
                                                                          .gender)
                                                                      ? "assets/image/Male_Icon.png"
                                                                      : "assets/image/Female_Icon.png",
                                                                  width: 14.0,
                                                                  height: 14.0,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: (card
                                                                        .data[
                                                                            index]
                                                                        .gender)
                                                                    ? " Male"
                                                                    : " Female",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ])),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0,
                                                              vertical: 5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/image/Cat_Icon.png",
                                                                      width:
                                                                          16.0,
                                                                      height:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        " ${card.data[index].type}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              card.data[index]
                                                                  .location,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              )),
                                        ),
                                      ));
                                    }),
                              );
                            }
                            return Container(
                                color: Colors.white,
                                child: Center(child: Text('No wishlist yet.')));
                          } else
                            return Center(
                              child: Text('No wishlist yet.'),
                            );
                        }),
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
      flex: 10,
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
                    padding: EdgeInsets.only(top: 50),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor: primarySwatch,
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white,
                        backgroundImage: notifier.getUserData.profilePicture !=
                                null
                            ? NetworkImage(notifier.getUserData.profilePicture)
                            : null,
                        child: notifier.getUserData.profilePicture != null
                            ? Text('')
                            : Text(
                                '${notifier.getUserData.username[0].toUpperCase()}',
                                style: TextStyle(
                                    color: primarySwatch, fontSize: 35),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '${notifier.getUserData.username}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text('${notifier.getUserData.email}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          elevation: 2,
                          color: Colors.white,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage())),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: primarySwatch, width: 1)),
                          child: Container(
                            width: 90,
                            child: Center(
                                child: Text(
                              'Edit Profile',
                              style:
                                  TextStyle(color: primarySwatch, fontSize: 13),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          elevation: 2,
                          color: primarySwatch,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPostPage())),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: primarySwatch, width: 1)),
                          child: Container(
                            width: 90,
                            child: Center(
                                child: Text(
                              'New Post',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
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
                child: Center(
                    child: Text(
                  'PROFILE',
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
            ),
            Positioned(
              top: 13,
              right: 8,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: primarySwatch,
                  size: 26,
                ),
                //onPressed: () => AuthService().signOut(),
                onPressed: () {
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
