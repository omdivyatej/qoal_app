import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoal_app/screens/rewards/card_design.dart';

import '../../../models/my_rewards.dart';
import 'package:qoal_app/screens/rewards/my_rewards_tab/my_rewards_tile.dart';
class MyRewards extends StatefulWidget {
  const MyRewards({Key? key}) : super(key: key);

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  @override
  Widget build(BuildContext context) {
    final myRewards= Provider.of<List<MyRewardsModel?>?>(context,listen:true);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        ListView.builder(
            itemBuilder: (context,index){
              return MyRewardTile(myRewardsModel: myRewards!=null?myRewards[index]:null);
        }),
        CardDesign(
          title: "Boat Headphones worth Rs. 1,999",
          description:
          "Get Free Boat XS Audio Probass Headphone worth 1,999 for free",
          allrewards: false,
          imageString: "assets/images/boat_headphone.png",
        ),
        SizedBox(
          height: 20,
        ),
        // CardDesign(
        //   title: "Amazon Gift Voucher worth Rs.200",
        //   description: "Get Free Amazon Gift Voucher worth Rs.200 for free",
        //   allrewards: false,
        //   imageString: "assets/images/amazon.png",
        // ),
        //CardDesign(),
      ],
    );
  }
}
