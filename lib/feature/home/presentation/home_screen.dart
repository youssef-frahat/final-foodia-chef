import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/app_config/app_icons.dart';
import 'package:foodia_chef/core/routes/routes.dart';
import 'package:foodia_chef/core/widgets/prov/prov.dart';
import 'package:foodia_chef/feature/home/presentation/all_order/presentation/screen/all_orders_screen.dart';
import 'package:foodia_chef/feature/home/presentation/canceled_requests/presentation/screen/canceled_requests_screen.dart';
import 'package:foodia_chef/feature/home/presentation/chef_info/chef_screen.dart';
import 'package:foodia_chef/feature/home/presentation/completed_requests/presentation/screen/completed_requests_screen.dart';
import 'package:foodia_chef/feature/home/presentation/requests_in_preparation/presentation/screen/request_in_preparation_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Control>(context, listen: false).NotiCont();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = [
      "طلبات قيد الانتظار",
      "طلبات قيد التحضير",
      "الطلبات المكتملة",
      "الطلبات الملغاة",
    ];

    List<Widget> allCategory = [
      AllOrdersScreen(),
      RequestsInPreparationScreen(),
      CompletedRequestsScreen(),
      CanceledRequestsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: InkWell(
            onTap: () {
              context.push(Routes.noti);

            },
            child: Stack(
              children: [
                Icon(
                  Icons.notifications,
                  size: 30.sp,
                  color: Colors.black,
                ),
                Positioned(
                  right: 0,
                  child: Consumer<Control>(
                    builder: (context, value, child) {
                      return value.noticont != null && value.noticont['data']['count'] > 0
                          ? CircleAvatar(
                              radius: 10.r,
                              backgroundColor: Colors.red,
                              child: Text(
                                "${value.noticont['data']['count']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: 3.h,
              color: Colors.grey[300],
            ),
            ChefScreen(),
            Divider(
              thickness: 3.h,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.sizeOf(context).width * 0.93,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            categoryNames[index],
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (selectIndex == index)
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            height: 2.h,
                            width: 110.w,
                            color: Colors.orange,
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.48,
              width: MediaQuery.sizeOf(context).width * 0.93,
              child: allCategory[selectIndex],
            ),
          ],
        ),
      ),
    );
  }
}
