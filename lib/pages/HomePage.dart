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
  String valueLocation, valueType, valueGender;
  List listLocation = ["Kuala Lumpur", "Selangor", "Negeri Sembilan"];
  List listType = ["Cat", "Dog"];
  List listGender = ["Male", "Female"];

  //sample list
  final List<String> listSample = [
    'assets/image/Dog 1.png',
    'assets/image/Dog 2.png',
    'assets/image/Dog 3.png',
    'assets/image/Dog 4.png',
    'assets/image/Dog 5.png',
    'assets/image/Dog 6.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              searchAndFilter(),
              //Adopt Us Title
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                    child: Text(
                  'ADOPT US',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primarySwatch, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 1, right: 1),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Location",
                              style: TextStyle(color: primarySwatch)),
                          style: TextStyle(color: primarySwatch, fontSize: 13),
                          underline: SizedBox(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: primarySwatch,
                          ),
                          value: valueLocation,
                          onChanged: (newValue) {
                            setState(() {
                              valueLocation = newValue;
                            });
                          },
                          items: listLocation.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primarySwatch, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Type",
                            style: TextStyle(color: primarySwatch)),
                        style: TextStyle(color: primarySwatch, fontSize: 13),
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: primarySwatch,
                        ),
                        value: valueType,
                        onChanged: (newValue) {
                          setState(() {
                            valueType = newValue;
                          });
                        },
                        items: listType.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primarySwatch, width: 1),
                          borderRadius: BorderRadius.circular(25)),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Gender",
                            style: TextStyle(color: primarySwatch)),
                        style: TextStyle(color: primarySwatch, fontSize: 13),
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: primarySwatch,
                        ),
                        value: valueGender,
                        onChanged: (newValue) {
                          setState(() {
                            valueGender = newValue;
                          });
                        },
                        items: listGender.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget homeGridView() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: listSample
            .map((item) => Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primarySwatch, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(item), fit: BoxFit.fill),
                        //borderRadius:
                      ),
                      child: Transform.translate(
                        offset: Offset(0, 50),
                        child: Container(
                          //width: 10,
                          //height: 10,
                          margin: EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                              //border:
                              //Border.all(color: primarySwatch, width: 2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Samantha",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              child: Icon(
                                            Icons.date_range,
                                            color: Colors.grey,
                                            size: 10,
                                          )),
                                          Container(
                                            child: Text("12/12",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          listGender[1],
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 11),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Dog",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11)),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              child: Icon(
                                            Icons.location_city,
                                            color: Colors.grey,
                                            size: 10,
                                          )),
                                          Container(
                                            child: Text(listLocation[0],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
