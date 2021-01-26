import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:assignment_project/model/pet.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String valueLocation, valueType, valueGender;
  // List listLocation = ["Kuala Lumpur", "Selangor", "Negeri Sembilan"];
  // List listType = ["Cat", "Dog"];
  // List listGender = ["Male", "Female"];

  Stream<List<Pet>> petsAll;

  @override
  void initState() {
    super.initState();
    UserNotifier notifier = Provider.of<UserNotifier>(context, listen: false);
    petsAll = DatabaseService().getAllPets(notifier.getUserUID);
  }

  //hello

  //sample list
  // final List<String> listSample = [
  //   'assets/image/Dog 1.png',
  //   'assets/image/Dog 2.png',
  //   'assets/image/Dog 3.png',
  //   'assets/image/Dog 4.png',
  //   'assets/image/Dog 5.png',
  //   'assets/image/Dog 6.png'
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //searchAndFilter(),
              //Adopt Us Title
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                    child: Text(
                  'ADOPTION FEED',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primarySwatch,
                      fontSize: 19),
                )),
              ),
              SizedBox(height: 30),
              homeGridView()
            ],
          )),
    );
  }

  Widget searchAndFilter() {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              //All
              children: [
                //isSearching
                //?
                // GestureDetector(
                //   onTap: () {
                //     //isSearching = false;
                //     //searchUsernameEditingController.text = "";
                //     //setState(() {});
                //   },
                //   child: Padding(
                //       padding: EdgeInsets.only(right: 12),
                //       child: Icon(Icons.arrow_back)),
                // ),
                //: Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: primarySwatch,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                                style: TextStyle(color: primarySwatch),
                                //controller: searchUsernameEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            primarySwatch.withOpacity(0.7))))),
                        GestureDetector(
                            onTap: () {
                              //if (searchUsernameEditingController.text != "") {
                              //onSearchButtonClick();
                              //}
                            },
                            child: Icon(Icons.search, color: primarySwatch))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //isSearching ? searchUsersList() : chatRoomList()
          ],
        ),
      ),
    );
  }

  Widget homeGridView() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<Pet>>(
            stream: petsAll,
            builder: (context, card) {
              if (card.hasData) {
                if (card.data.isNotEmpty) {
                  return Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: card.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                              child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PetDetailPage(
                                            pet: card.data[index])))
                              },
                              child: Column(
                                children: [
                                  Container(
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    '${card.data[index].images[0]}'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0)),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      '${card.data[index].petName}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      card.data[index]
                                                          .dateCreated
                                                          .toDate()
                                                          .toString()
                                                          .substring(0, 10),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: Row(children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Image.asset(
                                                          (card.data[index]
                                                                  .gender)
                                                              ? "assets/image/Male_Icon.png"
                                                              : "assets/image/Female_Icon.png",
                                                          width: 14.0,
                                                          height: 14.0,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: (card.data[index]
                                                                .gender)
                                                            ? " Male"
                                                            : " Female",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 5.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                            child: Image.asset(
                                                              "assets/image/Cat_Icon.png",
                                                              width: 16.0,
                                                              height: 16.0,
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
                                                      card.data[index].location,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                                ],
                              ),
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
    );
  }
}
