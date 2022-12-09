import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/models/activity_data_model.dart';
import 'package:qoal_app/models/leaderboard_model.dart';
import 'package:qoal_app/screens/leaderboard/leaderboard_tile.dart';
import 'package:qoal_app/widgets/spaces.dart';

import '../../models/user_model.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);
  static const routeName = '/Leaderboard';

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboard =
        Provider.of<List<LeaderboardModel?>?>(context, listen: true);
    print(leaderboard);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Leaderboard",
          style: TextStyle(
              color: Colors.black, fontSize: 25.sp, fontFamily: 'Poppins'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(20.h),
              Text(
                "Top 3",
                style: TextStyle(fontSize: 20.sp),
              ),
              VerticalSpace(20.h),
              // const LeaderboardPersonalData(),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return LeaderboardTile(
                      leaderboardUser: leaderboard != null
                          ? leaderboard[index]
                          : LeaderboardModel(
                              userName: "Loading Leaderboard",
                              total_trophies: 0),
                    );
                  }),
              VerticalSpace(20.h),
              Text(
                "Your Ranking",
                style: TextStyle(fontSize: 20.sp),
              ),
              VerticalSpace(20.h),
              PersonalRanking(),
              //const LeaderboardPersonalData(),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalRanking extends StatefulWidget {
  const PersonalRanking({Key? key}) : super(key: key);

  @override
  State<PersonalRanking> createState() => _PersonalRankingState();
}

class _PersonalRankingState extends State<PersonalRanking> {
  @override
  Widget build(BuildContext context) {
    final basicData = Provider.of<UserData?>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          width: 5,
          color: Colors.orange,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 18.r,
              child: Image.asset('assets/images/profile_icon_male.png'),
            ),
            HorizontalSpace(15.w),
            Text(basicData!.name.toString(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.sp,
                )),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, elevation: 0.0),
              icon: Image.asset(
                'assets/images/trophy_icon.png',
                scale: 12.r,
              ),
              label: Text(
                basicData.total_trophies.toString(),
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeaderboardPersonalData extends StatefulWidget {
  const LeaderboardPersonalData({Key? key}) : super(key: key);

  @override
  State<LeaderboardPersonalData> createState() =>
      _LeaderboardPersonalDataState();
}

class _LeaderboardPersonalDataState extends State<LeaderboardPersonalData> {
  @override
  Widget build(BuildContext context) {
    final activityDataModel =
        Provider.of<List<ActivityDataModel?>?>(context, listen: true);
    int mcoins = 0, mscore = 0, mcalories = 0;
    if (activityDataModel!.length == 1) {
      setState(() {
        mcoins = 0;
        mcalories = 0;
        mscore = 0;
      });
    } else {
      for (int i = 0; i < activityDataModel.length; i++) {
        if (activityDataModel[i]!.coins > mcoins) {
          mcoins = activityDataModel[i]!.coins;
        }
        if (activityDataModel[i]!.score > mscore) {
          mscore = activityDataModel[i]!.score;
        }
        if (activityDataModel[i]!.calories > mcalories) {
          mcalories = activityDataModel[i]!.calories;
        }
      }
    }
    print("$mcalories $mscore $mcoins");
    return Container(
      padding: EdgeInsets.all(18.r),
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
            "Personal Best",
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
              Text("Max score :",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  )),
              Text(mscore.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  )),
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
              Text("Max Coins Collected:",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              Text(mcoins.toString(),
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
              Text("Max Calories Burnt:",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              Text(mcalories.toString(),
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ],
          ),
          Divider(
            color: Colors.white70,
            thickness: .2,
            indent: 40.w,
            endIndent: 40.w,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Max Trophies:",
          //         style: TextStyle(fontSize: 16.sp, color: Colors.white)),
          //     Text("12",
          //         style: TextStyle(fontSize: 16.sp, color: Colors.white)),
          //   ],
          // ),
        ],
      ),
    );
  }
}
