
import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//DUE TO THE DESIGN .. IMPLEMENTING LOGIN + SIGNUP PAGE .. MAINTAIN LoginPage.dart naming
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLogin;
  bool _obscurePassword;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2 
    )
  );

  @override
  void initState() {
    _isLogin = true;
    _obscurePassword = true;
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
        backgroundColor: primarySwatch,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 200,),
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
                            SizedBox(height: 35,),
                            _passwordTextFormField(),
                            SizedBox(height: 35,),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 1000),
                              child: _isLogin ? SizedBox() : _confirmpasswordTextFormField(),
                            ),
                            _loginSignUpButton(),
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
              Positioned(
                top: 0,
                right: 0,
                child: FlatButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Skip', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20,),
                    ],
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
      padding: EdgeInsets.only(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_isLogin? 'New to Petdopt?' : 'Already have an Account?', style: TextStyle(color: Colors.white70, fontSize: 15),),
          RaisedButton(
            color: primarySwatch,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white)
            ),
            padding: EdgeInsets.all(13),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  !_isLogin ? 'LOGIN' : 'SIGN UP',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ),
            onPressed: () => setState(() => _isLogin = !_isLogin),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
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
            padding: EdgeInsets.only(left: 40, right: 40,top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  onLongPress: () {},
                  child: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.white,
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      size: 28,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  onLongPress: () {},
                  child: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: Image.asset(
                        'assets/image/google.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    radius: 27,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loginSignUpButton() {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.white)
      ),
      padding: EdgeInsets.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            _isLogin ? 'LOGIN' : 'SIGN UP',
            style: TextStyle(color: primarySwatch, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
      onPressed: _isLogin ?
      () {
        AuthService().signIn(_emailTextController.text.trim(), _passwordTextController.text.trim());
      } : () {
        AuthService().signUp(_emailTextController.text.trim(), _passwordTextController.text.trim());
      },
    );
  }

  Widget _emailTextFormField() {
    return TextFormField(
      controller: _emailTextController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: _borderDecoration,
        enabledBorder: _borderDecoration
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Invalid email address';
        } else {
          return null;
        }
      },
    );
  }

  Widget _passwordTextFormField() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        TextFormField(
          controller: _passwordTextController,
          obscureText: _obscurePassword,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: _borderDecoration,
            enabledBorder: _borderDecoration
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Cant Leave this field empty!';
            } else {
              return null;
            }
          },
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: Icon( _obscurePassword ? Icons.lock_outline : Icons.lock_open_outlined, color: Colors.white70,),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        )
      ],
    );
  }

  Widget _confirmpasswordTextFormField() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        TextFormField(
          controller: _confirmpasswordTextController,
          obscureText: _obscurePassword,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: _borderDecoration,
            enabledBorder: _borderDecoration
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Cant Leave this field empty!';
            }
            else if (value.trim() != _passwordTextController.text.trim()) {
              return 'Password does not match!';
            } else {
              return null;
            }
          },
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: Icon( _obscurePassword ? Icons.lock_outline : Icons.lock_open_outlined, color: Colors.white70,),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        )
      ],
    );
  }

}