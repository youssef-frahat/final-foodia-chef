import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../core/routes/routes.dart';
import '../logic/cubit/user_profile_cubit.dart';
import 'profile_field.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final SharedPreferences pref = getIt<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileError) {
          AppMessages.showError(context, state.error);
        } else if (state is LogoutError) {
          AppMessages.showError(context, state.error);
        } else if (state is LogoutSuccess) {
          AppMessages.showSuccess(context, AppStrings.logoutSuccess);
          context.go(Routes.login);
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          final userProfile = state.userProfile.data;

          if (userProfile == null) {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      25.height,
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: NetworkImage(
                          userProfile.image?.isNotEmpty == true
                              ? (userProfile.image!.startsWith('http')
                                  ? userProfile.image!
                                  : AppStrings.baseUrl + userProfile.image!)
                              : "https://imgs.search.brave.com/CbGx149KMAUXiJtL17989JkvB2aupjBKAvcBtUva0Yc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzEyLzM1Lzc3LzY0/LzM2MF9GXzEyMzU3/NzY0NDFfakR5RHRZ/amNxdnhSV2RySnBv/aGp4b1YwRGRmdTVY/YWsuanBn",
                        ),
                      ),
                      12.height,
                      Text(
                        userProfile.name ?? 'اسم غير متوفر',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      4.height,
                      Text(
                        userProfile.email ?? 'البريد الإلكتروني غير متوفر',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 30.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await context.pushNamed(
                              Routes.editProfileScreen,
                              extra: {
                                'name': userProfile.name ?? '',
                                'email': userProfile.email ?? '',
                                'phone': userProfile.phone ?? '',
                                'image':
                                    "${AppUrls.baseImage}${userProfile.image}",
                                'bio': userProfile.bio ?? '',
                              },
                            );

                            if (result == true) {
                              context
                                  .read<UserProfileCubit>()
                                  .getUserProfile();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        8.width,
                        GestureDetector(
                          onTap: () {
                            context
                                .read<UserProfileCubit>()
                                .getUserProfile();
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.refresh,
                              size: 16.sp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              30.height,
              ProfileField(
                title: 'الاسم:',
                value: userProfile.name ?? 'اسم غير متوفر',
              ),
              ProfileField(
                title: 'رقم الهاتف:',
                value: userProfile.phone ?? 'رقم الهاتف غير متوفر',
              ),
              ProfileField(
                title: 'البريد الالكتروني:',
                value: userProfile.email ?? 'البريد الإلكتروني غير متوفر',
              ),
              ProfileField(
                title: 'السيرة الذاتية:',
                value: userProfile.bio ?? 'السيرة الذاتية غير متوفرة',
              ),
              60.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: ElevatedButton(
                  onPressed: () {
                    pref.remove('isLoggedIn');
                    context.read<UserProfileCubit>().logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.red, width: 2.0.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8.w),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.red, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ),
              20.height,
            ],
          );
        } else if (state is LogoutLoading ||
            state is UserProfileLoading ||
            state is UserProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
