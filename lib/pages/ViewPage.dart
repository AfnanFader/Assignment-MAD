import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/pet.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/pages/EditProfilePage.dart';
import 'package:assignment_project/pages/NewPostPage.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int _current = 0;

  List<String> listSample = [
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: <Widget>[
                      CarouselSlider(
                        height: 200,
                        initialPage: 0,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        items: listSample.map((value) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: Image.asset(
                                  value,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                    ],
                  )),
                  SizedBox(height: 10),
                  detailsExpand()
                ],
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  backgroundColor: primarySwatch,
                  radius: 15,
                ))
          ],
        ),
      ),
    );
  }

  Widget detailsExpand() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Container(
                    child: Text(
                  'Samantha',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 19),
                )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        child: Icon(
                      Icons.android,
                      color: Colors.grey,
                      size: 15,
                    )),
                    Container(
                      child: Text(" Female",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        child: Icon(
                      Icons.timelapse,
                      color: Colors.grey,
                      size: 15,
                    )),
                    Container(
                      child: Text(" 15 Mins Ago",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        child: Icon(
                      Icons.android,
                      color: Colors.grey,
                      size: 15,
                    )),
                    Container(
                      child: Text(" Dog",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        child: Icon(
                      Icons.location_city,
                      color: Colors.grey,
                      size: 15,
                    )),
                    Container(
                      child: Text(" Kuala Lumpur",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 50,
            color: primarySwatch,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text("Breed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15)),
                    ),
                    Container(
                      child: Text(" | Dog",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Text("Vaccinated",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15)),
                    ),
                    Container(
                      child: Text(" | Yes",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text("Age",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15)),
                    ),
                    Container(
                      child: Text(" | 0.5 Years",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Text("Disabilities",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15)),
                    ),
                    Container(
                      child: Text(" | No",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: RaisedButton(
                  color: primarySwatch,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 15,
                      ),
                      Text("  Chat To Adopt",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: primarySwatch)),
                )),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text("Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  "Lorem Ipsum\nLoremIpsum\nLoremIpsum\nLoremIpsum",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
