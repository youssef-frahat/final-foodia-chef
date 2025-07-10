import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

  const ProfileField({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2.w),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          5.width,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
