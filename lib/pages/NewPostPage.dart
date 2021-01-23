import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/pet.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  final TextStyle _subHeadingTextStyle = TextStyle(fontSize: 18, color: primarySwatch, fontWeight: FontWeight.w700);
  final _borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: primarySwatch,
      width: 2 
    )
  );
  final _labelTextStyle = TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 20);
  //final _textInputStyle = TextStyle(fontSize: 18, color: Colors.black);

  final _postForm = GlobalKey<FormState>();
  final List<String> _petType = [
    'Cat', 'Dog', 'Hamster', 'Crocodile',
    'Birds', 'Elephant', 'Tiger' ,'Pet Type'
  ];
  final List<String> _malaysianStates = [
    'Johor', 'Kedah', 'N. Sembilan', 'Kelantan',
    'Melaka', 'Pahang', 'P. Pinang' , 'Perak',
    'Perlis', 'Sarawak', 'Sabah', 'Selangor',
    'Terengganu', 'K. Lumpur', 'Labuan',
    'Putrajaya', 'Select State'
  ];
  
  
  
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  String _petName;
  String _selectedPetType = 'Pet Type';
  double _age;
  String _selectedLocation = 'Select State';
  String _breed;
  bool _isVacinated;
  String _disabilities;
  bool _isMale;
  String _info;

    @override
  void initState() {
    
    super.initState();

    _petName = '';
    _breed = '';
    _disabilities = '';
    _info = '';
    _isVacinated = true;
    _isMale = true;
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [

              Positioned( //NEW POST
                top: 15,
                child: Container(
                  height: 35,
                  width: 150,
                  child: Center(child: Text('NEW POST', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19),)),
                  decoration: BoxDecoration(
                    color: primarySwatch,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.5),
                      bottomRight: Radius.circular(17.5)
                    )
                  ),
                ),
              ),
              
              Form(
                key: _postForm,
                child: Padding(
                  padding: EdgeInsets.only(top: 65, left: 25, right: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text('Upload Image', style: _subHeadingTextStyle,),

                        Padding(  //upload image
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 115,
                            child: ListView.builder(                          
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: OutlineButton(
                                    highlightColor: Colors.grey[100],
                                    child: images.asMap()[index] == null ?
                                      Icon(Icons.cloud_download, color: Colors.grey[700], size: 30,) :
                                      //Icon(Icons.ac_unit, color: Colors.grey[700], size: 30,),
                                      AssetThumb(
                                        asset: images[index],
                                        height: 110,
                                        width: 70,
                                      ),
                                    onPressed: (){
                                      loadAssets();
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: primarySwatch, width: 1) 
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Padding(  //pet name
                          padding: EdgeInsets.only(top: 25),
                          child: Container(
                            height: 60,
                            child: TextFormField(
                              //style: _textInputStyle,
                              decoration: InputDecoration(
                                focusedBorder: _borderDecoration,
                                enabledBorder: _borderDecoration,
                                labelText: '*Pet Name',
                                labelStyle: _labelTextStyle,
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                              maxLines: 1,
                              validator: (value) => _petName.isEmpty ? 'Pet Name must not be empty' : null,
                              onSaved: (value) => _petName = value.trim(),
                              onChanged: (value) {
                                setState(() => _petName = value);
                              },
                            ),
                          ),
                        ),

                        Padding(  //type and age
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            height: 60,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children : [
                                Row(
                                  children: [
                                    Expanded( //pet type form
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(width: 2, color: primarySwatch)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 2),
                                          child: DropdownButtonFormField<String>(
                                            //style: _textInputStyle,
                                            decoration: InputDecoration(
                                              fillColor: primarySwatch,
                                              focusColor: primarySwatch,
                                              hoverColor: primarySwatch,
                                              icon: Icon(Icons.pets, size: 20, color: primarySwatch,),
                                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                              hintText: 'Please select pet type',
                                            ),
                                            iconSize: 26,
                                            iconEnabledColor: primarySwatch,
                                            isExpanded: true,
                                            elevation: 0,
                                            value: _selectedPetType,
                                            items: _petType.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) => setState(() => _selectedPetType = value),
                                          ),
                                        )
                                      ),
                                    ),

                                    SizedBox(width: 10,),

                                    Expanded( //age
                                      child: Container(
                                        height: 50,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          //style: _textInputStyle,
                                          decoration: InputDecoration(
                                            focusedBorder: _borderDecoration,
                                            enabledBorder: _borderDecoration,
                                            labelText: '*Age (Year)',
                                            labelStyle: _labelTextStyle,
                                            floatingLabelBehavior: FloatingLabelBehavior.always
                                          ),
                                          maxLines: 1,
                                          validator: (value) =>   _age == null || _age == 0 ? 'Enter a valid age' : null,
                                          onSaved: (value) => _age = double.parse(value),
                                          onChanged: (value) {
                                            setState(() => _age = double.parse(value));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Positioned( //pet type wording
                                  top: 0,
                                  left: 4,
                                  child: Container(
                                    width: 80,
                                    color: Colors.white,
                                    child: Center(child: Text('*Pet Type', style: TextStyle(color: primarySwatch, fontSize: 15, fontWeight: FontWeight.bold),)),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),

                        Padding(  //location
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            height: 60,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children : [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(width: 2, color: primarySwatch)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 2),
                                          child: DropdownButtonFormField<String>(
                                            //style: _textInputStyle,
                                            decoration: InputDecoration(
                                              fillColor: primarySwatch,
                                              focusColor: primarySwatch,
                                              hoverColor: primarySwatch,
                                              icon: Icon(Icons.location_city, size: 20, color: primarySwatch,),
                                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                              hintText: 'Please select state',
                                            ),
                                            iconSize: 26,
                                            iconEnabledColor: primarySwatch,
                                            isExpanded: true,
                                            elevation: 0,
                                            value: _selectedLocation,
                                            items: _malaysianStates.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) => setState(() => _selectedLocation = value),
                                          ),
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  left: 4,
                                  child: Container(
                                    width: 80,
                                    color: Colors.white,
                                    child: Center(child: Text('*Location', style: TextStyle(color: primarySwatch, fontSize: 15, fontWeight: FontWeight.bold),)),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                        
                        Padding(  //breed
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              //style: _textInputStyle,
                              decoration: InputDecoration(
                                focusedBorder: _borderDecoration,
                                enabledBorder: _borderDecoration,
                                labelText: '*Breed',
                                labelStyle: _labelTextStyle,
                                floatingLabelBehavior: FloatingLabelBehavior.always
                              ),
                              maxLines: 1,
                              validator: (value) => _breed.isEmpty ? 'Pet Breed must not be empty' : null,
                              onSaved: (value) => _breed = value.trim(),
                              onChanged: (value) {
                                setState(() => _breed = value);
                              },
                            ),
                          ),
                        ),
                        
                        Padding(  //vaccine and dissabilities
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            height: 70,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('*Vaccinated', style: _subHeadingTextStyle,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () => setState(() => _isVacinated = true),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                  side: BorderSide(width: 2, color: _isVacinated==null? Colors.white : (
                                                    _isVacinated? Colors.blue : Colors.white
                                                  ))
                                                ),
                                                elevation: 5,
                                                child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  child: Center(
                                                    child: Text('Yes', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19),),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => setState(() => _isVacinated = false),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                  side: BorderSide(width: 2, color: _isVacinated==null? Colors.white : (
                                                    _isVacinated? Colors.white : Colors.blue
                                                  ))
                                                ),
                                                elevation: 5,
                                                child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  child: Center(
                                                    child: Text('No', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19),),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded( //disabilities
                                  child: Container(
                                    height: 50,
                                    child: TextFormField(
                                      //style: _textInputStyle,
                                      decoration: InputDecoration(
                                        focusedBorder: _borderDecoration,
                                        enabledBorder: _borderDecoration,
                                        labelText: 'Disabilities',
                                        labelStyle: _labelTextStyle,
                                        floatingLabelBehavior: FloatingLabelBehavior.always
                                      ),
                                      minLines: 1,
                                      //maxLines: 1,
                                      onSaved: (value) => _disabilities = value.trim(),
                                      onChanged: (value) {
                                        setState(() => _disabilities = value);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        Padding(  //gender
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Text('Gender',style: _subHeadingTextStyle,),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(() => _isMale = true),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(width: 2, color: _isMale==null? Colors.white : (
                                          _isMale? Colors.blue : Colors.white
                                        ))
                                      ),
                                      elevation: 5,
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          Icon(FontAwesomeIcons.mars, size: 20, color: Colors.blue,),
                                          SizedBox(width: 5,),
                                          Text('Male', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19),),
                                        ],),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() => _isMale = false),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(width: 2, color: _isMale==null? Colors.white : (
                                          _isMale? Colors.white : Colors.pink
                                        ))
                                      ),
                                      elevation: 5,
                                      child: Container(
                                        height: 30,
                                        width: 110,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          Icon(FontAwesomeIcons.venus, size: 20, color: Colors.pink,),
                                          SizedBox(width: 5,),
                                          Text('Female', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19),),
                                        ],),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        
                        Padding(  //additional info
                          padding: EdgeInsets.only(top: 25),
                          child: Container(
                            height: 400,
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: null,
                                maxLength: 1000,
                                decoration: InputDecoration(
                                  hintText: '\n\n\n\n\n\n\n\n                     Describe the Creature\n\n\n\n\n\n\n\n',
                                  focusedBorder: _borderDecoration,
                                  enabledBorder: _borderDecoration,
                                  labelText: 'Additional information',
                                  labelStyle: _labelTextStyle,
                                  floatingLabelBehavior: FloatingLabelBehavior.always
                                ),
                                onSaved: (value) => _info = value.trim(),
                                onChanged: (value) {
                                  setState(() => _info = value);
                                },
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(  //cancel and post
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
                                    side: BorderSide(color: primarySwatch, width: 2)
                                  ),
                                  onPressed: () {
                                    //_petNameController.dispose();
                                    Navigator.pop(context);
                                  } ,
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    child: Center(
                                      child: Text('Cancel', style: TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 17),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15,),
                                RaisedButton(
                                  color: primarySwatch,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side: BorderSide(color: primarySwatch, width: 2)
                                  ),
                                  onPressed: () {
                                    formValidation();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'Post', 
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontWeight: FontWeight.bold, 
                                          fontSize: 17
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(
                          height: 50,
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> loadAssets() async {
    String error = 'No Error Dectected';

    try {
      images = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "PetAdopt App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = images;
      _error = error;
    });
  }



  void formValidation(){

     UserNotifier noti = Provider.of<UserNotifier>(context, listen: false);

    if (_postForm.currentState.validate() && images != []){
        Pet newPost = Pet(
          uidCreator: noti.getUserUID,
          petName: _petName,
          type: _selectedPetType,
          age: _age,
          location: _selectedLocation,
          breed: _breed,
          vaccine: _isVacinated,
          cacat: _disabilities,
          gender: _isMale,
          info: _info,
          likedUsers: List(),
          dateCreated: Timestamp.now(),
          phoneNumber: noti.getUserData.phone,
        );
        _onSubmitPressed(newPost, noti);
      } else{
        print('debug form shows error handling');
      }
  }


  Future<bool> _onSubmitPressed(Pet data, UserNotifier userData) {
    return showDialog(
      context: context,
      builder: (context) => FutureBuilder<bool>(
        future: DatabaseService().submitNewPetPost(data, userData, images),
        builder: (context, snapshot) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.connectionState == ConnectionState.done) ... {
                    Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                          children: <TextSpan>[
                            if (snapshot.data) ... {
                              TextSpan(
                              text: 'Successfully post a pet!'
                              ),
                            } else ... {
                              TextSpan(
                              text: 'An error has occured during the upload-Error:conn.Error'
                              ),
                            }
                          ]
                        ),
                      )
                    ),
                    GestureDetector(
                      child: Text(
                        snapshot.data ? 'OK' : 'Try Again', 
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      onTap: snapshot.data ? () {
                        Navigator.of(context).pop(true);
                        Navigator.pop(context);
                        //Navigator.pop(context);
                      } : () {
                        Navigator.of(context).pop(false);
                      },
                    )
                  } else ... {
                    Center(
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CircularProgressIndicator(),
                    ),
                  )
                  }
                ],
              ),
            ),
          );
        },
      )
    );
  }


}


