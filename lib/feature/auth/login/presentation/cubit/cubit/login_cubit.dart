import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/models/failures.dart';
import '../../../data/model/auth_response_model/login/login_response_model.dart';
import '../../../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository) : super(LoginInitial());
  final LoginRepository loginRepository;

  Future<void> login({
    required String phone,
    required String password,
    required String fcm,
  }) async {
    emit(LoginLoading());
    final result = await loginRepository.login(
      phone: phone,
      password: password,
      fcm: fcm,
    );
    print("Login result: $result");
    print("Login result: $result");
    print("Login result: $result");
    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(
          LoginError(
            failure.message,
          ),
        );
      }
      if (failure is NetworkFailure) {
        emit(
          LoginError(
            failure.message,
          ),
        );
      }
      if (failure is AuthFailure) {
        emit(
          LoginError(
            failure.message,
          ),
        );
      }
      if (failure is VerificationFailure) {
        emit(
          LoginError(
            failure.message,
          ),
        );
      }
    }, (user) async {
      emit(
        LoginSuccess(user: user),
      );
    });
  }
}
