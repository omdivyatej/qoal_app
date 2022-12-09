import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/widgets/spaces.dart';

import '../../models/user_model.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const routeName = '/profile';
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    void _settingsPanel() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          builder: (context) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const SettingForm());
          });
    }

    final basicData = Provider.of<UserData?>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 25.sp, fontFamily: 'Poppins'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45.r,
                    child: Image.asset("assets/images/profile_icon_male.png"),
                  ),
                ),
                VerticalSpace(20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowData(
                        title: "Name",
                        value: basicData != null
                            ? basicData.name
                            : "No user found!"),
                    RowData(
                        title: "Age",
                        value: basicData != null
                            ? basicData.age.toString()
                            : "No user found!"),
                    RowData(
                        title: "Height",
                        value: basicData != null
                            ? "${basicData.height} cm"
                            : "No user found!"),
                    RowData(
                        title: "Weight",
                        value: basicData != null
                            ? "${basicData.weight} kg"
                            : "No user found!"),
                  ],
                ),
                VerticalSpace(30.h),
                ElevatedButton.icon(
                    onPressed: () {
                      _settingsPanel();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.blue[600],
                        elevation: 5.0,
                        minimumSize: const Size.fromHeight(50)),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    )),
                VerticalSpace(25.h),
                ElevatedButton.icon(
                    onPressed: () async {
                      await _authService.signOutUser();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.redAccent,
                        elevation: 5.0,
                        minimumSize: const Size.fromHeight(50)),
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}

class RowData extends StatefulWidget {
  final String title;
  final String value;

  const RowData({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.value,
            style: TextStyle(fontSize: 20.sp, color: Colors.grey[500]),
          ),
          VerticalSpace(4.h),
          Divider(
            height: 0,
            thickness: 0.2,
            color: Colors.grey[900],
          ),
        ],
      ),
    );
  }
}

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  double weight = 0.0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: true);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Profile Update",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
            ),
            VerticalSpace(10.h),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // initialValue: "40",
              decoration: textInputDecoration.copyWith(
                hintText: 'Enter Weight (kg)',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (val) {
                setState(() {
                  weight = double.parse(val);
                });
              },
            ),
            VerticalSpace(30.h),
            ElevatedButton(
              onPressed: () async {
                dynamic result =
                    await DatabaseService(uid: user!.uid).updateProfile(weight);
                if (result != null) {
                  print("Weight updated");
                }
                Navigator.pop(context);
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
                  "Update",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
            VerticalSpace(40.h),
          ],
        ),
      ),
    );
  }
}

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.blue, width: 1, style: BorderStyle.solid)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)));
