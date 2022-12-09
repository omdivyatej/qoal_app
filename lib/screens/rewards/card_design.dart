import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/spaces.dart';

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
    return Column(
      children: [
        Container(
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
                  : Row(),
    SizedBox(height: 20,)
            ],
          ),
        ),
      ],
    );
    //
  }
}