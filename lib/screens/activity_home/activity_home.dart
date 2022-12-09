import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/models/activity_data_model.dart';

import '../../models/user_model.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({Key? key}) : super(key: key);
  static const routeName = "/activityhome";

  @override
  State<ActivityHome> createState() => _ActivityHomeState();
}

class _ActivityHomeState extends State<ActivityHome> {
  DateTime selectedDate = DateTime.now();
  int coins = 0, score = 0, calories = 0;
  double time = 0.0;
  int totalCoins = 0, totalScore = 0, totalCalories = 0;
  double totalTime = 0.0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: true);
    List<ActivityDataModel?>? activityList =
        Provider.of<List<ActivityDataModel?>?>(context, listen: true);

    // print(activityList?.elementAt(2)?.coins.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Activity",
          style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Center(
          child: Column(
            children: const [
              Text(
                "Coming soon!",
                style: TextStyle(fontSize: 20),
              ),
              // DatePicker(
              //   DateTime(2022, 9, 9, 0, 0,
              //       0), //DateTime.now(), // replace with Joining date
              //   height: 100,
              //   width: 80,
              //   initialSelectedDate:
              //       DateTime(2022, 9, 9, 0, 0, 0), //DateTime.now(),
              //   selectionColor: Colors.blueAccent,
              //   daysCount: 10,
              //   onDateChange: (date) {
              //     selectedDate = date;
              //     DateFormat dateFormat = DateFormat("MM-dd-yyyy HH:mm:ss");
              //
              //     activityList?.forEach((activityData) {
              //       DateTime activityDate =
              //           dateFormat.parse(activityData?.dateTime ?? "0");
              //       if (activityDate.day == selectedDate.day) {
              //         print("true");
              //         print(activityDate.day);
              //         print(selectedDate.day);
              //         coins = activityData!.coins;
              //         calories = activityData.calories;
              //         score = activityData.score;
              //         time = (activityData.time / 60);
              //
              //         setState(() {
              //           totalCoins += coins;
              //           totalCalories += calories;
              //           totalScore += score;
              //           totalTime += time;
              //         });
              //       } else {
              //         setState(() {
              //           totalCoins = 0;
              //           totalScore = 0;
              //           totalCalories = 0;
              //           totalTime = 0;
              //         });
              //       }
              //     });
              //     setState(() {});
              //     print(totalCoins);
              //     print(totalCalories);
              //     print(totalScore);
              //     print(totalTime);
              //   },
              // ),
              // VerticalSpace(10.h),
              // const Divider(
              //   height: 1,
              //   thickness: 0.3,
              //   color: Colors.black,
              // ),
              // VerticalSpace(10.h),
              // ActivityCardWidget(
              //   coins: totalCoins.toString(),
              //   time: totalTime.toStringAsFixed(1),
              //   calories: totalCalories.toString(),
              //   score: totalScore.toString(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityCardWidget extends StatelessWidget {
  String? coins = "", score = "", time = "", calories = "";
  ActivityCardWidget({
    Key? key,
    this.coins,
    this.score,
    this.time,
    this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orangeAccent.shade700,
              Colors.blueAccent.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            "Activity Data",
            style: TextStyle(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Score:",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                score!,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white70,
            thickness: .2,
            indent: 40.w,
            endIndent: 40.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Coins Collected:",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              Text(coins!,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ],
          ),
          Divider(
            color: Colors.white70,
            thickness: .2,
            indent: 40.w,
            endIndent: 40.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Calories Burnt:",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              Text(calories!,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ],
          ),
          Divider(
            color: Colors.white70,
            thickness: .2,
            indent: 40.w,
            endIndent: 40.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total time:",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              Text(time!,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
