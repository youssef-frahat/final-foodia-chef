import 'package:flutter/material.dart';

class BalanceCardWidget extends StatelessWidget {
  final String amount;
  const BalanceCardWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      margin: EdgeInsets.only(right: 4, left: 4),
      decoration: BoxDecoration(
        color: Color(0xfffd8b19),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr, // هنا التغيير الرئيسي
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: 156,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/wallet_card.jpg"),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 24, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "رصيدك الحالي",
                        style: TextStyle(
                          fontFamily: "Lemonada",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '$amount جنية',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: "Lemonada",
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(), // أفضل من Expanded + SizedBox
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "FOODIA",
                          style: TextStyle(
                            fontFamily: "Lemonada",
                            color: Colors.white60,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   width: double.infinity,
    //   height: 225.h,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/card.png'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Padding(
    //     padding: REdgeInsets.symmetric(horizontal: 20, vertical: 30),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [

    //       20.height,
    //         Text(
    //           '$amount جنية', //! handel Amount
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 32.sp,
    //             fontFamily: 'Lemonada',
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         50.height,
    //         Align(
    //           alignment: Alignment.bottomLeft,
    //           child: Text(
    //             'FOODIA',
    //             style: TextStyle(
    //               color: Colors.black,
    //               fontSize: 20.sp,
    //               fontFamily: 'Lemonada',
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
