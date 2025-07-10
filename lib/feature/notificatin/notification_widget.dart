import 'package:flutter/material.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    super.key,
    required this.notificationTitle,
    required this.notificationDescription,
    required this.newNotification,
  });
  final AppColors appColors = AppColors();
  final String notificationTitle;
  final String notificationDescription;
  final bool newNotification;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 132,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: appColors.orange),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Flexible(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      newNotification
                          ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: appColors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                          : SizedBox(),
                      Expanded(child: SizedBox()),
                      Text(
                        notificationTitle,
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: appColors.orange,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    notificationDescription,
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: appColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/logo.jpg",
                  width: 52,
                  height: 52,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
