import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/app_config/font_styles.dart';
import '../../../../core/di/dependency_injection.dart';
import '../logic/cubit/user_profile_cubit.dart';
import '../widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserProfileCubit>()..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.profile, style: FontStyles.body25W600),
          centerTitle: true,
        ),
        body:  ProfileBody(),
      ),
    );
  }
}
