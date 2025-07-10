import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:foodia_chef/feature/auth/login/presentation/widget/signup_prompt_row.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_config/app_images.dart';
import '../../../../../core/helpers/messages.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';
import '../../../../../core/widgets/text_form_field/password_field.dart';
import '../cubit/cubit/login_cubit.dart';
import 'remember_me_row.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({
    super.key,
  });

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  late TextEditingController _phoneController, _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _isRememberMeChecked = false;
  var fbm = FirebaseMessaging.instance;
  String tokendevice = '';
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    GetTokenDevice();
  }

  Future GetTokenDevice() async {
    await fbm.requestPermission();
    fbm.getToken().then((value) {
      tokendevice = value!;
      print("token== $value");
      print("token== $value");
      print("token== $value");
      print("token2");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          AppMessages.showLoading(context);
        } else if (state is LoginSuccess) {
          AppMessages.showSuccess(context, AppStrings.loginSuccess);
          context.go(Routes.bottomNavBar);
        } else if (state is LoginError) {
          Navigator.of(context, rootNavigator: true).pop();
          AppMessages.showError(
            context,
            state.error,
          );
          log("error from state ${state.error}");
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 186.w,
                    height: 186.h,
                  ),
                ),
                Text(
                  AppStrings.login,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000),
                  ),
                ),
                73.height,
                CustomTextField(
                  label: AppStrings.phone,
                  controller: _phoneController,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  hint: AppStrings.enterPhone,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return AppStrings.pleaseEnterYourPhone;
                    }
                    return null;
                  },
                ),
                12.height,
                PasswordField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  hint: AppStrings.enterPassword,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return AppStrings.pleaseEnterYourPassword;
                    }
                    return null;
                  },
                ),
                12.height,
                RememberMeRow(
                  onRememberChanged: (bool value) {
                    setState(() {
                      _isRememberMeChecked = value;
                    });
                  },
                ),
                12.height,
                CustomButton(
                  text: AppStrings.login1,
                  backgroundColor: AppColors.buttonColor,
                  radius: Radius.circular(50.r),
                  height: 50.h,
                  onTap: () async {
                    if (!_isRememberMeChecked) {
                      AppMessages.showError(
                          context, 'يجب الموافقة على شرط تذكرني أولاً');
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      await context.read<LoginCubit>().login(
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            fcm: tokendevice,
                          );
                    }
                    print("token4");
                  },
                  textColor: null,
                ),
                60.height,
                SignupPromptRow(),
                135.height,
              ],
            ),
          ),
        );
      },
    );
  }
}
