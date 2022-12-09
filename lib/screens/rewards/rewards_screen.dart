import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qoal_app/screens/rewards/all_rewards_tab/all_rewards.dart';
import 'package:qoal_app/widgets/spaces.dart';

import 'package:qoal_app/screens/rewards/my_rewards_tab/my_rewards.dart';
class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);
  static const routeName = '/reward';

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.deepOrange,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Rewards",
            style: TextStyle(color: Colors.white, fontSize: 25.sp),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Rewards",
              ),
              Tab(
                text: "My Rewards",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: const AllRewardTab(),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: const MyRewards(),
            ),
          ],
        ),
      ),
    );
  }
}
