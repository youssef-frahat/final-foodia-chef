import 'package:flutter/material.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/widgets/prov/prov.dart';
import 'package:foodia_chef/feature/notificatin/notification_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final AppColors appColors = AppColors();

  final List notifications = [
    {
      "notificationTitle": "تم قبول طلبك",
      "notificationDescription":
          "طلبك “كفته مشويه” من الشيف فاطمة قيد التحضير. سيتم إعلامك عند الانتهاء!",
      "newNotification": true,
    },
    {
      "notificationTitle": " تم رفض طلبك",
      "notificationDescription":
          "طلبك “كباب فحم” من الشيف حاتم تم رفضه بسبب عدم توفر أحد الأصناف. يمكنك إعادة الطلب في وقت لاحق",
      "newNotification": false,
    },
    {
      "notificationTitle": " اكله جديدة",
      "notificationDescription":
          "الشيف فاطمة أضافت طبق محشي ورق العنب بالطريقة المصرية الأصيلة ! جربه الآن واستمتع بألذ طعم بيتي.",
      "newNotification": false,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Control>(context, listen: false).Noti();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(
      builder: (context, val, child) {
        return Scaffold(
          backgroundColor: appColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: Icon(PhosphorIcons.arrowBendUpLeft(), size: 24),
            ),
            centerTitle: true,
            title: Text(
              "الإشعارات",
              style: TextStyle(
                fontFamily: "Lemonada",
                color: appColors.orange,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body:
              val.noti == null
                  ? Center(child: CircularProgressIndicator())
                  : val.noti['status'] == false
                  ? Center(child: Text("no data"))
                  : ListView.builder(
                    itemCount: val.noti['data']['notifications'].length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          val.ReadNoti(
                            val.noti['data']['notifications'][index]['id'],
                          );
                          dialogNoti(
                            context,
                            val.noti['data']['notifications'][index]['title'],
                            val.noti['data']['notifications'][index]['description'],
                          );

                        },
                        child: NotificationWidget(
                          notificationTitle:
                              val.noti['data']['notifications'][index]['title'],
                          notificationDescription:
                              val.noti['data']['notifications'][index]['description'],
                          newNotification:
                              val.noti['data']['notifications'][index]['is_read'] ==
                                      0
                                  ? true
                                  : false,
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }
}

dialogNoti(BuildContext context, String title, String description) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("حسناً"),
          ),
        ],
      );
    },
  );
}
