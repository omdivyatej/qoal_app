import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qoal_app/widgets/spaces.dart';

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

class AllRewardTab extends StatefulWidget {
  const AllRewardTab({Key? key}) : super(key: key);

  @override
  State<AllRewardTab> createState() => _AllRewardTabState();
}

class _AllRewardTabState extends State<AllRewardTab> {
  @override
  Widget build(BuildContext context) {
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
        const CardDesign(
          title: "Boat Headphones worth Rs. 1,999",
          description:
              "Get Free Boat XS Audio Probass Headphone worth 1,999 for free",
          amount: 200,
          imageString: "assets/images/boat_headphone.png",
        ),
        VerticalSpace(20.h),
        const CardDesign(
          title: "Amazon Gift Voucher worth Rs.200",
          description: "Get Free Amazon Gift Voucher worth Rs.200 for free",
          amount: 100,
          imageString: "assets/images/amazon.png",
        ),
        //CardDesign(),
      ],
    );
  }
}

class CardDesign extends StatefulWidget {
  final String title;
  final int amount;
  final String description;
  final String imageString;
  final bool allrewards;
  const CardDesign(
      {Key? key,
      required this.title,
      required this.description,
      this.amount = 0,
      required this.imageString,
      this.allrewards = true})
      : super(key: key);

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.imageString),
              fit: BoxFit.cover,
              opacity: 0.5,
              alignment: Alignment.center),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.cyan,
              Colors.purpleAccent,
            ],
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent),
          ),
          VerticalSpace(10.h),
          Text(
            widget.description,
            style: TextStyle(color: Colors.grey[100], fontSize: 14.sp),
          ),
          VerticalSpace(10.h),
          widget.allrewards
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          elevation: 0.0,
                        ),
                        child: Text(
                          "Redeem",
                          style: TextStyle(fontSize: 12.sp),
                        )),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.currency_exchange,
                        color: Colors.black,
                      ),
                      label: Text(widget.amount.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreenAccent,
                      ),
                    )
                  ],
                )
              : Row()
        ],
      ),
    );
    //SizedBox(height: 20,);
  }
}

class MyRewards extends StatefulWidget {
  const MyRewards({Key? key}) : super(key: key);

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
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
        CardDesign(
          title: "Amazon Gift Voucher worth Rs.200",
          description: "Get Free Amazon Gift Voucher worth Rs.200 for free",
          allrewards: false,
          imageString: "assets/images/amazon.png",
        ),
        //CardDesign(),
      ],
    );
  }
}
