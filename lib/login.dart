import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qoal_app/widgets/spaces.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    animationsInit();

    super.initState();
  }

  animationsInit() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 0.0, end: 1.6), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 1.6, end: 1.0), weight: 30),
      TweenSequenceItem<double>(tween: Tween(begin: 1.0, end: 1.2), weight: 10),
      TweenSequenceItem<double>(tween: Tween(begin: 1.2, end: 1.0), weight: 10),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Transform.scale(
                        scale: _sizeAnimation.value,
                        child: Image.asset(
                          "assets/images/qoal_logo_new.png",
                          scale: 1.5,
                        ),
                      )),
                  VerticalSpace(25.h),
                  TextFormField(
                    decoration:
                    textInputDecorationAuth.copyWith(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  VerticalSpace(20.h),
                  TextFormField(
                    decoration:
                    textInputDecorationAuth.copyWith(hintText: "Password"),
                  ),
                  VerticalSpace(20.h),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.blue[600],
                        elevation: 0.0,
                        //minimumSize: const Size.fromHeight(50)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Log In",
                          style:
                          TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      )),
                  VerticalSpace(20.h),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registerProfile');
                      },
                      style: TextButton.styleFrom(),
                      child: const Text(
                        "SIGN UP NOW",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var textInputDecorationAuth = InputDecoration(
    fillColor: Colors.grey.shade200,
    filled: true,
    contentPadding: const EdgeInsets.only(left: 25),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
          color: Colors.transparent, width: 1, style: BorderStyle.solid),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ));
