import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/screens/activity_home/activity_home.dart';
import 'package:qoal_app/widgets/screen_padding.dart';
import 'package:qoal_app/widgets/spaces.dart';

import '../../models/user_model.dart';
import '../profile/profile_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _MyAppState();
}

class _MyAppState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  int totalCalories = 0;
  String country = '', city = '', zip = '', timezone = '';

  @override
  void initState() {
    animationsInit();
    super.initState();
    setState(() {});
    String uid = FirebaseAuth.instance.currentUser!.uid;
  }

  void _settingsPanelSecretCode() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        builder: (context) {
          return const SecretCode();
        });
  }

  animationsInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 0.0, end: 1.4), weight: 70),
      TweenSequenceItem<double>(tween: Tween(begin: 1.4, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatNumber(String number) {
    int n1 = int.parse(number);
    var formatter = NumberFormat('#,##,##0');
    String n = formatter.format(n1);
    return n;
  }

  String formatName(String name) {
    var a = name.split(" ");
    var firstName = a[0];
    return firstName;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: true);
    final basicData = Provider.of<UserData?>(context, listen: true);
    print(user!.uid);
    print(basicData);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ScreenPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(15.h),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.scale(
                    scale: _sizeAnimation.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: IconButton(
                            onPressed: () {
                              _settingsPanelSecretCode();
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ProfilePage.routeName);
                          },
                          child: CircleAvatar(
                            radius: 22.r,
                            child: Image.asset(
                                'assets/images/profile_icon_male.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                VerticalSpace(20.h),
                /////////////////////////////Name Part//////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DelayedDisplay(
                      slidingBeginOffset: const Offset(0.0, 0.55),
                      child: Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    DelayedDisplay(
                      slidingBeginOffset: const Offset(.35, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.account_balance_wallet_sharp,
                          size: 45.sp,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(0.0, 0.55),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -12.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          basicData != null
                              ? formatName(basicData.name)
                              : "No user!",
                          style: TextStyle(
                            fontSize: 41.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /////////////////4 block part/////////////////////////////////////
                Text(
                  "Total stats",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17.sp,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                ),
                VerticalSpace(8.h),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DelayedDisplay(
                          delay: const Duration(milliseconds: 300),
                          slidingBeginOffset: const Offset(-.35, 00),
                          child: Container(
                            padding: EdgeInsets.all(10.0.r),
                            //color: Colors.orangeAccent.shade100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.shade100,
                            ),

                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35.r,
                                  child: Image.asset(
                                    'assets/images/fire_icon.png',
                                  ),
                                ),
                                VerticalSpace(10.h),
                                Text(
                                  basicData != null
                                      ? formatNumber(
                                          basicData.total_calories_burnt)
                                      : "No user!",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 22.sp),
                                ),
                                Text(
                                  "Cal Burnt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      HorizontalSpace(10.w),
                      Expanded(
                        child: DelayedDisplay(
                          delay: const Duration(milliseconds: 300),
                          slidingBeginOffset: const Offset(.35, 00),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8.0.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.shade50,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 17.r,
                                        child: Image.asset(
                                          'assets/images/hour_glass.png',
                                        ),
                                      ),
                                      HorizontalSpace(8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              basicData != null
                                                  ? "${formatNumber(basicData.total_time_h)}h"
                                                  : "No user!",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 21.sp),
                                            ),
                                            Text(
                                              "total time",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              VerticalSpace(8.h),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue.shade50,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 17.r,
                                        child: Image.asset(
                                          'assets/images/points_icon.png',
                                        ),
                                      ),
                                      HorizontalSpace(8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              basicData != null
                                                  ? formatNumber(
                                                      basicData.total_points)
                                                  : "No user!",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 21.sp),
                                            ),
                                            Text(
                                              "total points",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: 'Poppins',
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                VerticalSpace(10.h),
                //////////////////////////////3 block part////////////////////////////////////////////////////////
                DelayedDisplay(
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    padding: EdgeInsets.all(17.r),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/GameStats');
                          },
                          child: Column(
                            children: [
                              Icon(Icons.bookmark, size: 44.sp),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/GameStats');
                                },
                                child: Text(
                                  "game Stats",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'Poppins',
                                    fontSize: 12.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              basicData != null
                                  ? formatNumber(basicData.total_sessions)
                                  : "0!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 30.sp),
                            ),
                            Text(
                              "total sessions",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12.sp,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ActivityHome.routeName);
                          },
                          child: Column(
                            children: [
                              Icon(Icons.leaderboard, size: 44.sp),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ActivityHome.routeName);
                                },
                                child: Text(
                                  "activity",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalSpace(10.h),
                ////////////////////////////////////////Leaderboard Part//////////////////////////////////
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(Leaderboard.routeName);
                    Navigator.pushNamed(context, '/Leaderboard');
                  },
                  child: DelayedDisplay(
                    delay: const Duration(milliseconds: 600),
                    slidingBeginOffset: const Offset(00, -.45),
                    slidingCurve: Curves.bounceOut,
                    child: Container(
                      padding: EdgeInsets.all(17.r),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/l_icon.png',
                            scale: 10,
                          ),
                          HorizontalSpace(8.w),
                          Text(
                            "Leaderboard",
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontFamily: 'Poppins',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecretCode extends StatefulWidget {
  const SecretCode({Key? key}) : super(key: key);

  @override
  State<SecretCode> createState() => _SecretCodeState();
}

class _SecretCodeState extends State<SecretCode> {
  bool obscureCode = true;
  String codeButtonText = "Show Code";
  @override
  Widget build(BuildContext context) {
    final basicData = Provider.of<UserData?>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Secret Code",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
          ),
          VerticalSpace(10.h),
          TextFormField(
            obscureText: obscureCode,
            initialValue: basicData!.secret_code,
            enabled: false,
            decoration: textInputDecoration,
          ),
          VerticalSpace(30.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (obscureCode == true) {
                  obscureCode = false;
                  codeButtonText = "Hide Code";
                } else {
                  obscureCode = true;
                  codeButtonText = "Show Code";
                }
              });
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                primary: Colors.blue[600],
                elevation: 5.0,
                minimumSize: const Size.fromHeight(50)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                codeButtonText,
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
          ),
          VerticalSpace(40.h),
        ],
      ),
    );
  }
}
