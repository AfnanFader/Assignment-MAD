import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/pages/BlogPage.dart';
import 'package:assignment_project/pages/ChatPage.dart';
import 'package:assignment_project/pages/HomePage.dart';
import 'package:assignment_project/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true
  );

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => _selectedIndex = index,
          children: [
            HomePage(
              key: PageStorageKey('HomePage'),
            ),
            BlogPage(
              key: PageStorageKey('BlogPage'),
            ),
            ChatPage(
              key: PageStorageKey('ChatPage'),
            ),
            ProfilePage(
              key: PageStorageKey('ProfilePage'),
            )
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 2,
                color: Colors.grey[300]
              )
            ),
          ),
          child: SalomonBottomBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
              });
            },
            items: [
              SalomonBottomBarItem(

                icon: Icon(FontAwesomeIcons.home),
                title: Text('Home')
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.newspaper),
                title: Text('Blog')
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.commentAlt),
                title: Text('Chat')
              ),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.idBadge),
                title: Text('Profile')
              ),
            ],
          ),
        ),
      ),
    );
  }
}