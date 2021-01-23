import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _editProfileForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _locationController;
  bool _isMale;
  String _userID;

  final _borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.grey[500], width: 2));

  @override
  void initState() {
    UserNotifier notifier = Provider.of<UserNotifier>(context, listen: false);
    _isMale = notifier.getUserData.isMale;
    _userID = notifier.getUserUID;
    _nameController =
        TextEditingController(text: notifier.getUserData.username);
    _emailController = TextEditingController(text: notifier.getUserData.email);
    _phoneController = TextEditingController(text: notifier.getUserData.phone);
    _locationController =
        TextEditingController(text: notifier.getUserData.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Form(
            key: _editProfileForm,
            child: Stack(
              children: [
                SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: CircleAvatar(
                              backgroundColor: primarySwatch,
                              radius: 50,
                              child: CircleAvatar(
                                radius: 48,
                                backgroundColor: Colors.white,
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primarySwatch,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Change Picture',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[500]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: _nameController,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter Username',
                                  enabledBorder: _borderDecoration,
                                  focusedBorder: _borderDecoration),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter Email',
                                  enabledBorder: _borderDecoration,
                                  focusedBorder: _borderDecoration),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: TextFormField(
                              controller: _phoneController,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Phone',
                                  enabledBorder: _borderDecoration,
                                  focusedBorder: _borderDecoration),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: TextFormField(
                              controller: _locationController,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Location',
                                  labelStyle: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.normal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText:
                                      'No 23, USJ Height 5,\nJalan Padu Gila, Shah Alam,\n42300, Selangor',
                                  enabledBorder: _borderDecoration,
                                  focusedBorder: _borderDecoration),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 70,
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Text('Gender',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              setState(() => _isMale = true),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                    color: _isMale
                                                        ? Colors.blue
                                                        : Colors.white,
                                                    width: 2)),
                                            elevation: _isMale ? 0 : 5,
                                            child: Container(
                                              width: 100,
                                              height: 33,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.mars,
                                                    size: 22,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Male',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              setState(() => _isMale = false),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                    color: _isMale
                                                        ? Colors.white
                                                        : Colors.blue,
                                                    width: 2)),
                                            elevation: _isMale ? 5 : 0,
                                            child: Container(
                                              width: 100,
                                              height: 33,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.venus,
                                                    size: 22,
                                                    color: Colors.pink,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('Female',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17))
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: BorderSide(
                                            color: primarySwatch, width: 2)),
                                    onPressed: () {},
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Discard',
                                          style: TextStyle(
                                              color: primarySwatch,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  RaisedButton(
                                    color: primarySwatch,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: BorderSide(
                                            color: primarySwatch, width: 2)),
                                    onPressed: () {
                                      DatabaseService().updateUser(
                                          _userID,
                                          _emailController.text.trim(),
                                          _nameController.text.trim(),
                                          _locationController.text.trim(),
                                          _phoneController.text.trim(),
                                          _isMale);
                                        
                                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox( width: 15, height: 15 ,child: CircularProgressIndicator()),
                                              SizedBox(width: 10,),
                                              Text('Updating profile ...'),
                                            ],
                                          )
                                        ));
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: primarySwatch,
                      size: 40,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
