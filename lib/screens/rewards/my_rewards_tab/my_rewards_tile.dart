import 'package:flutter/material.dart';
import 'package:qoal_app/screens/rewards/card_design.dart';

import '../../../models/my_rewards.dart';

class MyRewardTile extends StatelessWidget {
  const MyRewardTile({Key? key, this.myRewardsModel}) : super(key: key);
  final MyRewardsModel? myRewardsModel;
  @override
  Widget build(BuildContext context) {
    return CardDesign(title: myRewardsModel != null
        ? myRewardsModel!.title.toString()
        : "No name", description: myRewardsModel != null
        ? myRewardsModel!.description.toString()
        : "No name", imageString: "assets/images/amazon.png",allrewards: false,);
  }
}
