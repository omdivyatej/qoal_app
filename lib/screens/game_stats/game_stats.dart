import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qoal_app/screens/leaderboard/leaderboard.dart';
import 'package:qoal_app/widgets/spaces.dart';

class GameStats extends StatefulWidget {
  const GameStats({Key? key}) : super(key: key);

  @override
  State<GameStats> createState() => _GameStatsState();
}

class _GameStatsState extends State<GameStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Game Stats",
          style: TextStyle(
              color: Colors.black, fontSize: 25.sp, fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const LeaderboardPersonalData(),
            VerticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}
