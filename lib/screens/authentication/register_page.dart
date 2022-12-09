import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qoal_app/base_client.dart';
import 'package:qoal_app/login.dart';
import 'package:qoal_app/widgets/spaces.dart';

import '../../services/auth.dart';
import '../../services/database.dart';

class RegisterProfile extends StatefulWidget {
  const RegisterProfile({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;
  static const routeName = '/register';
  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  String age = "";
  String height = "";
  String weight = "";
  final AuthService _authService = AuthService();
  String error = "";
  String referral_code = "No code";
  int total_trophies = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //   const VerticalSpace(100),
                          Image.asset(
                            "assets/images/qoal_logo_new.png",
                            scale: 1.5,
                          ),
                          VerticalSpace(25.h),
                          /////////////////Full Name//////////////////
                          TextFormField(
                            decoration: textInputDecorationAuth.copyWith(
                                hintText: "Full Name"),
                            onChanged: (val) {
                              setState(() {
                                fullName = val;
                              });
                            },
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) {
                                  return "Enter Full Name";
                                }
                              } else {
                                return null;
                              }
                            },
                          ),
                          VerticalSpace(20.h),
                          ////////////Age///////////
                          TextFormField(
                            decoration: textInputDecorationAuth.copyWith(
                                hintText: "Age"),
                            onChanged: (val) {
                              setState(() {
                                age = val;
                              });
                            },
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) {
                                  return "Enter Age";
                                }
                              } else {
                                return null;
                              }
                            },
                          ),
                          VerticalSpace(20.h),
                          Row(
                            children: [
                              Expanded(
                                ///////////Height/////////////
                                child: TextFormField(
                                  decoration: textInputDecorationAuth.copyWith(
                                      hintText: "Height (cm)"),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      height = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val != null) {
                                      if (val.isEmpty) {
                                        return "Enter Height";
                                      }
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              HorizontalSpace(15.w),
                              Expanded(
                                ////////////Weight//////////////////
                                child: TextFormField(
                                  decoration: textInputDecorationAuth.copyWith(
                                      hintText: "Weight (kg)"),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      weight = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val != null) {
                                      if (val.isEmpty) {
                                        return "Enter Weight";
                                      }
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          VerticalSpace(20.h),
                          //////Referral ////////////////////////////
                          TextFormField(
                            decoration: textInputDecorationAuth.copyWith(
                                hintText: "Referral code (Optional)"),
                            keyboardType: TextInputType.text,
                            onChanged: (val) {
                              setState(() {
                                referral_code = val;
                              });
                            },
                          ),
                          VerticalSpace(20.h),
                          ////////////Email//////////////////////
                          TextFormField(
                            decoration: textInputDecorationAuth.copyWith(
                                hintText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) {
                                  return "Enter Email Address";
                                }
                              } else {
                                return null;
                              }
                            },
                          ),
                          VerticalSpace(20.h),
                          TextFormField(
                            ///////////////////Password///////////////////
                            decoration: textInputDecorationAuth.copyWith(
                                hintText: "Password"),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) {
                                  return "Enter Password";
                                }
                              } else {
                                return null;
                              }
                            },
                          ),
                          VerticalSpace(20.h),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic a = await DatabaseService(uid: "")
                                      .referalIsValid(referral_code);

                                  if (a == 1) {
                                    print("Code is valid");
                                    setState(() {
                                      total_trophies = 20;
                                    });
                                  } else {
                                    total_trophies = 0;
                                  }
                                  var response = await BaseClient()
                                      .getLocationData(
                                          "http://ip-api.com/json");

                                  dynamic result =
                                      await _authService.registerUser(
                                          email,
                                          password,
                                          height,
                                          weight,
                                          fullName,
                                          age,
                                          response["country"],
                                          response["city"],
                                          response["zip"],
                                          response["timezone"],
                                          total_trophies);
                                  FirebaseAuth.instance.signOut();

                                  if (result == null) {
                                    print("Error");
                                    setState(() {
                                      loading = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Registration error",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
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
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ),
                              )),
                          VerticalSpace(20.h),
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggleView();
                              //Navigator.pushNamed(context, '/login');
                            },
                            style: TextButton.styleFrom(),
                            child: const Text(
                              "LOG IN NOW",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
