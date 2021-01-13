
import 'dart:async';

import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/user.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


//DUE TO THE DESIGN .. IMPLEMENTING LOGIN + SIGNUP PAGE .. MAINTAIN LoginPage.dart naming
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLogin;
  bool _obscurePassword;
  bool _obscurePassword2;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2 
    )
  );
  final _borderDecorationError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.yellow,
      width: 2 
    )
  );

  @override
  void initState() {
    _isLogin = true;
    _obscurePassword = true;
    _obscurePassword2 = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmpasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: primarySwatch,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 80),
                    child: Container(
                      height: 150,
                      child: Image.asset(
                        'assets/image/logo.png',
                        
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.black,
                        child: Column(
                          children: [
                            _emailTextFormField(),
                            SizedBox(height: 10,),
                            _passwordTextFormField(),
                            SizedBox(height: _isLogin ?20:10,),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 1000),
                              child: _isLogin ? SizedBox() : _confirmpasswordTextFormField(),
                            ),
                            if (!_isLogin) ... {
                              SizedBox(height: 40,)
                            },
                            _loginSignUpButton(context),
                            // Consumer<UserNotifier>(
                            //   builder: (context, not, widget) {
                            //     return Center(child: Text(not.ayammas),);
                            //   },
                            // ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 1000),
                              child: _isLogin ? _forgotPassword() : SizedBox()
                            ),
                            _changeLoginSignUp()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              //ANONYMOUS USER ENTRY
              Positioned( //skip button
                top: 0,
                right: 0,
                child: FlatButton(
                  child: Container(
                    width: 60,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('SKIP', style: TextStyle(color: primarySwatch, fontSize: 13),),
                        Icon(Icons.arrow_right, color: primarySwatch, size: 20,),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget _changeLoginSignUp() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_isLogin? 'New to Petdopt?' : 'Already have an Account?', style: TextStyle(color: Colors.white70, fontSize: 14),),
          SizedBox(height: 5,),
          RaisedButton(
            color: primarySwatch,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white)
            ),
            padding: EdgeInsets.all(13),
            child: Container(
              height: 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  !_isLogin ? 'LOGIN' : 'SIGN UP',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            onPressed: () => setState(() => _isLogin = !_isLogin),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword() { ///google sign in as well
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: (MediaQuery.of(context).size.width/2)-100,height: 1,color: Colors.white,),
                Text('Or Connect with', style: TextStyle(color: Colors.white70),),
                Container(width: (MediaQuery.of(context).size.width/2)-100,height: 1,color: Colors.white,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    final provider = Provider.of<UserNotifier>(context, listen: false);
                    provider.googleLogin();
                    // .then((value) => provider.setUserUID = 
                    // );
                  },
                  // onTap: () {
                  //   signInWithGoogle().whenComplete(() {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return LoginPage();
                  //         },
                  //       ),
                  //     );
                  //   });
                  // },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: Image.asset(
                        'assets/image/GoogleSignIn.png',
                        
                      ),
                    ),
                   
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loginSignUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.white)
      ),
      padding: EdgeInsets.all(12),
      child: Container(
        height: 15,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            _isLogin ? 'LOGIN' : 'SIGN UP',
            style: TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      onPressed: _isLogin ?
      () {
        AuthService().signIn(_emailTextController.text.trim(), _passwordTextController.text.trim());
      } : () {
        if (_formKey.currentState.validate()) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( width: 15, height: 15 ,child: CircularProgressIndicator()),
                SizedBox(width: 10,),
                Text('Checking details ...'),
              ],
            )
          ));
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => RegisterPage(
          //     email: _emailTextController.text.trim(),
          //     password: _passwordTextController.text.trim(),
          //   )
          // ));
          Timer(Duration(milliseconds: 2500), () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => RegisterPage(
              email: _emailTextController.text.trim(),
              password: _passwordTextController.text.trim(),)
          )));
        }
      },
    );
  }

  Widget _emailTextFormField() {
    return Container(
      // color: Colors.black,
      height: 70,
      child: TextFormField(
        // onEditingComplete: () =>_formKey.currentState.validate(),
        onChanged: (value) => _formKey.currentState.validate(),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextController,
        style: TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can\'t Leave this field empty!';
          } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'Invalid Email Address';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _passwordTextFormField() {
    return Container(
      // color: Colors.black,
      height: 70,
      child: TextFormField(
        // onEditingComplete: () =>_formKey.currentState.validate(),
        onChanged: (value) => _formKey.currentState.validate(),
        controller: _passwordTextController,
        obscureText: _obscurePassword,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword? Icons.lock : Icons.lock_open, color: Colors.white, size: 18,),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can\'t Leave this field empty!';
          } else if (value.trim().length < 6){
            return ('Password Lenght must be at least 6.');
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _confirmpasswordTextFormField() {
    return Container(
      height: 70,
      child: TextFormField(
        // onEditingComplete: () =>_formKey.currentState.validate(),
        onChanged: (value) => _formKey.currentState.validate(),
        enabled: !_isLogin,
        controller: _confirmpasswordTextController,
        obscureText: _obscurePassword2,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword2? Icons.lock : Icons.lock_open, color: Colors.white, size: 18,),
            onPressed: () => setState(() => _obscurePassword2 = !_obscurePassword2),
          ),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can\'t Leave this field empty!';
          }
          else if (value.trim() != _passwordTextController.text.trim()) {
            return 'Password does not match!';
          } else {
            return null;
          }
        },
      ),
    );
  }

}


class RegisterPage extends StatefulWidget {
  final String email;
  final String password;
  RegisterPage({this.email, this.password});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isMale;
  String _email, _password;
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();
  final _registerScaffoldKey = GlobalKey<ScaffoldState>();
  final _borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2 
    )
  );
  final _borderDecorationError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.yellow,
      width: 2 
    )
  );

  @override
  void initState() {
    _email = widget.email;
    _password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _registerScaffoldKey,
        backgroundColor: primarySwatch,
        body: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 80),
                  child: Form(
                    key: _registerFormKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('YOU TOT IT\'S THAT EZ ???', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Container(child: Image.asset('assets/image/hang.gif', fit: BoxFit.cover,)),
                          SizedBox(height: 20,),
                          _usernameTextFormField(),
                          SizedBox(height: 10,),
                          _phoneTextFormField(),
                          SizedBox(height: 10,),
                          _addressTextFormField(),
                          _genderPick(),
                          SizedBox(height: 180,),
                          _submitButton(context)
                        ],
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 30,),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameTextFormField() {
    return Container(
      // color: Colors.black,
      height: 70,
      child: TextFormField(
        // onEditingComplete: () =>_registerFormKey.currentState.validate(),
        onChanged: (value) => _registerFormKey.currentState.validate(),
        controller: _usernameTextController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can\'t leave this field empty!';
          } else if (value.trim().length < 6) {
            return 'At least 6 characters for Username';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _phoneTextFormField() {
    return Container(
      // color: Colors.black,
      height: 70,
      child: TextFormField(
        // onEditingComplete: () =>_registerFormKey.currentState.validate(),
        onChanged: (value) => _registerFormKey.currentState.validate(),
        keyboardType: TextInputType.phone,
        controller: _phoneTextController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Phone',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Can\'t leave this field empty!';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _addressTextFormField() {
    return Container(
      // color: Colors.black,
      height: 120,
      child: TextFormField(
        maxLines: 3,
        controller: _addressTextController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.yellow),
          isDense: true,
          errorBorder: _borderDecorationError,
          focusedErrorBorder: _borderDecoration,
          labelText: 'Address (Optional)',
          hintStyle: TextStyle(color: Colors.white54),
          hintText: 'No 45, Taman Selayang,\nBandar Baru, Puchong,\n50803, Kuala Lumpur',
          labelStyle: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: _borderDecoration,
          enabledBorder: _borderDecoration
        ),
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Invalid Address';
        //   } else {
        //     return null;
        //   }
        // },
      ),
    );
  }

  Widget _genderPick() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Gender',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white)),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => setState(()=>_isMale=true),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: _isMale==null?Colors.white:(_isMale?Colors.blue:Colors.white),width: 2)
                      ),
                      elevation: _isMale==null?5:(_isMale?0:5),
                      child: Container(
                        width: 100,
                        height: 33,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.mars, size: 22,color: Colors.blue,),
                            SizedBox(width: 5,),
                            Text('Male', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(()=>_isMale=false),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: _isMale==null?Colors.white:(_isMale?Colors.white:Colors.blue),width: 2)
                      ),
                      elevation: _isMale==null?5:(_isMale?5:0),
                      child: Container(
                        width: 100,
                        height: 33,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.venus, size: 22,color: Colors.pink,),
                            SizedBox(width: 5,),
                            Text('Female', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17))
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
    );
  }

  Widget _submitButton(BuildContext prov) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.white)
      ),
      padding: EdgeInsets.all(12),
      child: Container(
        height: 19,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      onPressed: () {
        if (_registerFormKey.currentState.validate() && _isMale != null) {
          _registerScaffoldKey.currentState.showSnackBar(_registerSnackBarStatus(prov));
        } else if (_isMale == null) {
          _registerScaffoldKey.currentState.showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red,),
                SizedBox(width: 10,),
                Text('Gender not selected')
              ],
            ),
          ));
        }
      }
    );
  }

  // Future<bool> _testrun() {
  //   return Future.delayed(Duration(seconds: 3)).then((value) => true);
  // }

  Widget _registerSnackBarStatus(BuildContext context) {
    return SnackBar(
      content: FutureBuilder<bool>(
        // future: _testrun(),
        future: AuthService().signUp(
          _email, _password,
          UserDetail(
            email: _email, address: _addressTextController.text,
            isMale: _isMale, phone: _phoneTextController.text,
            username: _usernameTextController.text, postDoc: null, wishlist: null
          )
        ),
        builder: (context, snapshot) {
          UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
          if (snapshot.data == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( width: 15, height: 15 ,child: CircularProgressIndicator()),
                SizedBox(width: 10,),
                Text('Registering New User ...'),
              ],
            );
          } else {
            if (snapshot.data) {
              Future.delayed(Duration(seconds: 1)).then((value) {
                Navigator.pop(context);
                userNotifier.setEnable = true;
              });
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text('Completed .. !!')
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error,color: Colors.red,),
                  SizedBox(width: 10,),
                  Text('Failed .. Please try again !')
                ],
              );
            }
          }
        },
      ),
    );
  }
}