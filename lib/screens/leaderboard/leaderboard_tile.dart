import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qoal_app/models/leaderboard_model.dart';

import '../../widgets/spaces.dart';

class LeaderboardTile extends StatefulWidget {
  LeaderboardTile({
    Key? key,
    required this.leaderboardUser,
  }) : super(key: key);
  final LeaderboardModel? leaderboardUser;

  @override
  State<LeaderboardTile> createState() => _LeaderboardTileState();
}

class _LeaderboardTileState extends State<LeaderboardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 5),
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
            Text(
                widget.leaderboardUser != null
                    ? widget.leaderboardUser!.userName.toString()
                    : "No name",
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
                widget.leaderboardUser != null
                    ? widget.leaderboardUser!.total_trophies.toString()
                    : "0",
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
