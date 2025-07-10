import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/widgets/prov/prov.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_router.dart';

class Foodia extends StatelessWidget {
  final String initialRoute;

  const Foodia({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 922),
      splitScreenMode: true,
      minTextAdapt: true,
      child: ChangeNotifierProvider(
        create: (context) => Control(),
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter(initialLocation: initialRoute).router, // ✅ التعديل هنا
          title: 'Foodia Chef',
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
