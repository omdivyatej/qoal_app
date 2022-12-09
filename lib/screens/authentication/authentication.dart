import 'package:flutter/material.dart';
import 'package:qoal_app/screens/authentication/login_page.dart';
import 'package:qoal_app/screens/authentication/register_page.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  late bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return LoginPage(toggleView:toggleView);
    }else{
      return RegisterProfile(toggleView:toggleView);
    }
  }
}
