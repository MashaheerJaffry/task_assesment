import 'package:flutter/material.dart';
import 'package:task_assesment/utlis/app_color.dart';
import 'package:task_assesment/utlis/text_style.dart';
import '../models/user_model.dart';
import '../services/contact_services.dart';
import '../services/date_fetch.dart';
import '../services/distance_calculation.dart';

class UserCard extends StatefulWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Future<String> getLocation() async => await calculateDistanceFromUser(
      widget.user.latitude, widget.user.latitude);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width - size.width * 0.04,
      height: size.height * 0.25,
      margin: EdgeInsets.all(size.width * 0.03),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: AppColor.userTileBg,
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: AppColor.blueColor,
                    size: size.width * 0.04,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    'Dinner',
                    style: AppStyle()
                        .style516
                        .copyWith(fontSize: size.width * 0.035),
                  ),
                ],
              ),
              Icon(Icons.more_horiz, size: size.width * 0.05),
            ],
          ),
          Divider(indent: size.width * 0.02, endIndent: size.width * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.picture),
                        backgroundColor: AppColor.blueColor,
                        radius: size.width * 0.07,
                      ),
                      Positioned(
                        top: size.width * 0.1,
                        left: size.width * 0.1,
                        child: CircleAvatar(
                          radius: size.width * 0.02,
                          backgroundColor: AppColor.onlineColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.user.name} - ${widget.user.age}',
                        style: AppStyle()
                            .style514
                            .copyWith(fontSize: size.width * 0.035),
                      ),
                      DistanceText(
                        targetLatitude: widget.user.latitude,
                        targetLongitude: widget.user.latitude,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ContactInfo().launchEmail(widget.user.email);
                    },
                    icon: Icon(Icons.message,
                        color: AppColor.blueColor, size: size.width * 0.06),
                  ),
                  IconButton(
                    onPressed: () {
                      ContactInfo().launchPhone(widget.user.phone);
                    },
                    icon: Icon(Icons.phone,
                        color: AppColor.blueColor, size: size.width * 0.06),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month,
                            color: AppColor.blackColor,
                            size: size.width * 0.04),
                        SizedBox(width: size.width * 0.01),
                        Text('Date',
                            style: AppStyle()
                                .style512
                                .copyWith(fontSize: size.width * 0.03)),
                      ],
                    ),
                    Text(
                      FormatDateTime().formatDate(widget.user.timezone),
                      style: AppStyle()
                          .style514
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                    Text(
                      FormatDateTime().formatTime(widget.user.timezone),
                      style: AppStyle()
                          .style514
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  height: size.height * 0.05,
                  width: 1,
                  color: AppColor.greyColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: AppColor.blackColor,
                            size: size.width * 0.04),
                        SizedBox(width: size.width * 0.01),
                        Text('Location',
                            style: AppStyle()
                                .style512
                                .copyWith(fontSize: size.width * 0.03)),
                      ],
                    ),
                    Text(
                      widget.user.city.length > 10 ||
                              widget.user.country.length > 10
                          ? '${widget.user.city},\n${widget.user.country}'
                          : '${widget.user.city}, ${widget.user.country}',
                      style: AppStyle()
                          .style514
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
