import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/screens/rewards/all_rewards_tab/all_reward_tile.dart';

import '../../../models/rewards_model.dart';
import '../../../widgets/spaces.dart';

class AllRewardTab extends StatefulWidget {
  const AllRewardTab({Key? key}) : super(key: key);

  @override
  State<AllRewardTab> createState() => _AllRewardTabState();
}

class _AllRewardTabState extends State<AllRewardTab> {
  @override
  Widget build(BuildContext context) {
    final rewards= Provider.of<List<Rewards_Model?>?>(context,listen:true);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpace(3.h),
        Text(
          "Available Balance : 300",
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 0,
          color: Colors.black,
        ),
        VerticalSpace(10.h),
        ListView.builder(
            itemCount:  rewards!=null?rewards.length:1,
            itemBuilder: (context, index) {
              return AllRewardTile(rewards_model: rewards!=null?rewards[index]:null);
    }),

        //
        // const CardDesign(
        //   title: "Boat Headphones worth Rs. 1,999",
        //   description:
        //   "Get Free Boat XS Audio Probass Headphone worth 1,999 for free",
        //   amount: 200,
        //   imageString: "assets/images/boat_headphone.png",
        // ),
        // VerticalSpace(20.h),
        // const CardDesign(
        //   title: "Amazon Gift Voucher worth Rs.200",
        //   description: "Get Free Amazon Gift Voucher worth Rs.200 for free",
        //   amount: 100,
        //   imageString: "assets/images/amazon.png",
        // ),
        //CardDesign(),
      ],
    );
  }
}
