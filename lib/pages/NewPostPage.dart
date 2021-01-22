import 'package:assignment_project/model/localSetting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {

  final TextStyle _subHeadingTextStyle = TextStyle(fontSize: 18, color: primarySwatch, fontWeight: FontWeight.w700);
  final _editPostForm = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _disablitiesController = TextEditingController();
  final TextEditingController _addInfoController = TextEditingController();
  final List<String> _petType = [
    'Cat', 'Dog', 'Hamster', 'Crocodile',
    'Birds', 'Elephant', 'Tiger' ,'Pet Type'
  ];
  String _dropdownvalue = 'Pet Type';
  final _borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: primarySwatch,
      width: 2 
    )
  );
  final _labelTextStyle = TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 20);
  final _textInputStyle = TextStyle(fontSize: 18, color: Colors.black);

  bool _isVacinated;
  bool _isMale;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [

              Positioned(
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
                key: _editPostForm,
                child: Padding(
                  padding: EdgeInsets.only(top: 65, left: 25, right: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text('Upload Image', style: _subHeadingTextStyle,),

                        Padding(
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
                                // return Padding(
                                //   padding: EdgeInsets.only(right: 15),
                                //   child: Card(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(15),
                                //         side: BorderSide(color: primarySwatch, width: 1) 
                                //       ),
                                //       child: Container(
                                //         width: 100,
                                //         height: 40,
                                //         child: Icon(Icons.cloud_download, color: Colors.grey[700], size: 30,),
                                //       ),
                                //     ),
                                // );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              style: _textInputStyle,
                              controller: _petNameController,
                              decoration: InputDecoration(
                                focusedBorder: _borderDecoration,
                                enabledBorder: _borderDecoration,
                                labelText: 'Pet Name',
                                labelStyle: _labelTextStyle,
                                floatingLabelBehavior: FloatingLabelBehavior.always
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            height: 60,
                            // color: Colors.red,
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
                                          child: DropdownButton<String>(
                                            style: _textInputStyle,
                                            iconSize: 26,
                                            iconEnabledColor: primarySwatch,
                                            isExpanded: true,
                                            elevation: 0,
                                            value: _dropdownvalue,
                                            items: _petType.map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) => setState(() => _dropdownvalue = value),
                                          ),
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          style: _textInputStyle,
                                          controller: _ageController,
                                          decoration: InputDecoration(
                                            focusedBorder: _borderDecoration,
                                            enabledBorder: _borderDecoration,
                                            labelText: 'Age (Year)',
                                            labelStyle: _labelTextStyle,
                                            floatingLabelBehavior: FloatingLabelBehavior.always
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  left: 4,
                                  child: Container(
                                    width: 80,
                                    color: Colors.white,
                                    child: Center(child: Text('Pet Type', style: TextStyle(color: primarySwatch, fontSize: 15, fontWeight: FontWeight.bold),)),
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              style: _textInputStyle,
                              controller: _breedController,
                              decoration: InputDecoration(
                                focusedBorder: _borderDecoration,
                                enabledBorder: _borderDecoration,
                                labelText: 'Breed',
                                labelStyle: _labelTextStyle,
                                floatingLabelBehavior: FloatingLabelBehavior.always
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
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
                                        Text('Vaccinated', style: _subHeadingTextStyle,),
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
                                                elevation: _isVacinated==null? 5: (_isVacinated? 0:5),
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
                                                elevation: _isVacinated==null? 5: (_isVacinated? 5:0),
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
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    child: TextFormField(
                                      style: _textInputStyle,
                                      controller: _disablitiesController,
                                      decoration: InputDecoration(
                                        focusedBorder: _borderDecoration,
                                        enabledBorder: _borderDecoration,
                                        labelText: 'Disabilities',
                                        labelStyle: _labelTextStyle,
                                        floatingLabelBehavior: FloatingLabelBehavior.always
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        Padding(
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
                        
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Container(
                            height: 400,
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: null,
                                maxLength: 1000,
                                //style: _textInputStyle,
                                controller: _addInfoController,
                                decoration: InputDecoration(
                                  hintText: '\n\n\n\n\n\n\n\n                     Describe the Creature\n\n\n\n\n\n\n\n',
                                  focusedBorder: _borderDecoration,
                                  enabledBorder: _borderDecoration,
                                  labelText: 'Additional information',
                                  labelStyle: _labelTextStyle,
                                  floatingLabelBehavior: FloatingLabelBehavior.always
                                ),
                              ),
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
                                    side: BorderSide(color: primarySwatch, width: 2)
                                  ),
                                  onPressed: () {
                                    //_petNameController.dispose();
                                    images = [];
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
                                  onPressed: () {},
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    child: Center(
                                      child: Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
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



}

