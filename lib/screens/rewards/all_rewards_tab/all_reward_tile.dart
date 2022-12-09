import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/rewards_model.dart';
import '../../../models/user_model.dart';
import 'package:qoal_app/screens/rewards/card_design.dart';

class AllRewardTile extends StatelessWidget {
  AllRewardTile({Key? key, required this.rewards_model}) : super(key: key);
  final Rewards_Model? rewards_model;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: true);
    final rewards = Provider.of<List<Rewards_Model?>?>(context, listen: true);
    return CardDesign(
        title: rewards_model != null
            ? rewards_model!.title.toString()
            : "No name", description: rewards_model != null
        ? rewards_model!.description.toString()
        : "No name", imageString:  "assets/images/amazon.png",amount: rewards_model!=null?rewards_model!.price:0,);
  }
}
