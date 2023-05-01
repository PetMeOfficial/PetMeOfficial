import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'constant.dart';

class ProfileListItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);



  @override
  State<ProfileListItem> createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 5,
      ).copyWith(
        bottom: kSpacingUnit.w * 4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: const Color(0xFF487776),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            size: kSpacingUnit.w * 4.0,
            color: const Color(0xFFF5F5DC),
          ),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text(
            widget.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: const Color(0xFFF5F5DC)
            ),
          ),
          const Spacer(),
          if (widget.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              color: const Color(0xFFF5F5DC),
              size: kSpacingUnit.w * 3.0,
            ),
        ],
      ),
    );
  }
}