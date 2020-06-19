import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourcartapp/your_cart_app/ui/delivery_address.dart';
import 'package:yourcartapp/your_cart_app/ui/sign_in.dart';
import 'dart:async';
import 'package:yourcartapp/your_cart_app/ui/shoppingList.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
enum FormType{
  login,
  register,
}
class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final formkey= GlobalKey<FormState>();
  String _email;
  String _password;
  FormType formtype=FormType.login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text("Your Cart"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: formkey,
            child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildInputs()+ buildsubmitButtons(),
                    ),//login
                   // button
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text("Or", style: TextStyle(
                        fontSize: 15,
                          color: Colors.grey)),
                    ),//or
      OutlineButton(
        splashColor: Colors.red.shade500,
        onPressed: () {
            signInWithGoogle().whenComplete(() => {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ShoppingList();
              }))
            });
        },
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        highlightElevation: 10,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("images/google_logo.png"),height: 25.0,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Sign in with Google", style: TextStyle(
                    color: Colors.black
                ),),
              )
            ],
        ),

      )// google login
                  ],
                ),
              ),
            ),
            ),
          )
        ],

      ),
    );
     }
 bool ValidAndSave() {

    final form= formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
     return false;
    }

 }
 Future<void>  validAndSubmit(BuildContext context)  async {
    if(ValidAndSave()){
      try{
        if(formtype==FormType.login) {
          FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: _email, password: _password)).user;
          print("signed in user ${user.uid}");
          Navigator.push(this.context, MaterialPageRoute(builder: (context)=>ShoppingList()));
        }
        else{
          FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print("registered user ${user.uid}");

      }
      }
      catch(e){
        print ('error : ${e.message}');
        if(e.message=='The password is invalid or the user does not have a password.'){
        print ('error : ${e.message}');
        _displaySnackBar(context);}
        else if(e.message=='There is no user record corresponding to this identifier. The user may have been deleted.'){
          _displaySnackBar2(context);
        }else{
          _displaySnackBar3(context);

    }
              }
    }
 }
  void moveToRegiste(){
    formkey.currentState.reset();
    setState(() {
      formtype= FormType.register;
    });
  }
  List<Widget> buildInputs(){
    return[  Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: TextFormField(
        validator: (value)=>value.isEmpty? "E-mail can't be empty": null,
        onSaved: (value)=> _email=value,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            hintText: "Enter your email-id"
        ),
      ),
    ),//enter your name
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: TextFormField(
          validator: (value)=>value.isEmpty? "password can't be empty": null,
          obscureText: true,
          onSaved: (value)=> _password=value,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              hintText: "Password"
          ),
        ),
      ),//
    ];

  }
  List<Widget> buildsubmitButtons(){
    if(formtype==FormType.login){
    return[
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: RaisedButton(onPressed: ()=> validAndSubmit(this.context),
            disabledColor: Colors.red.shade700,
            color: Colors.red.shade700,
            child: Text("Login",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ))),
      ),
      FlatButton(onPressed:()=> moveToRegiste(),
        child: Text("Create a account in your cart", style: TextStyle(
            fontWeight: FontWeight.w500
        ),),),
    ];}
    else{
      return[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: RaisedButton(onPressed: ()=> validAndSubmit(this.context),
              disabledColor: Colors.red.shade700,
              color: Colors.red.shade700,
              child: Text("create an account",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ))),
        ),
        FlatButton(onPressed:()=> moveToLogin(),
          child: Text("Have an account?login", style: TextStyle(
              fontWeight: FontWeight.w900
          ),),),
      ];
    }
  }
  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      formtype= FormType.login;

    });
  }
  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('re-enter your password and email-id', style: TextStyle(fontSize: 15)),
    backgroundColor: Colors.red.shade700,
    duration: Duration(seconds: 2),);
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }
  _displaySnackBar2(BuildContext context) {
    final snackBar = SnackBar(content: Text("You don't have a account in Your cart", style: TextStyle(fontSize: 15)),
      backgroundColor: Colors.red.shade700,
      duration: Duration(seconds: 2),);
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }
  _displaySnackBar3(BuildContext context) {
    final snackBar = SnackBar(content: Text("You already have a account", style: TextStyle(fontSize: 15)),
      backgroundColor: Colors.red.shade700,
      duration: Duration(seconds: 2),);
    _scaffoldKey.currentState.showSnackBar(snackBar);

  }
  }
