import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';
import 'package:foodia_chef/core/network/api_services.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_req_model.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_res_model.dart';
import 'package:foodia_chef/feature/home/data/repo/update_status_order/update_status_order_repo.dart';
import 'dart:developer';

import '../../../../../../core/app_config/app_strings.dart';
import '../../../../../../core/helpers/connectivity_helper.dart';
import '../../../../../../core/models/failures.dart';
import '../../../../../../core/models/exceptions.dart';

class OrderStatusRepositoryImpl extends OrderStatusRepository {
  final ApiService apiService;

  OrderStatusRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, UpdateStatusOrderResponseModel>> updateOrderStatus({
    required int orderId,
    required UpdateStatusOrderRequestModel request,
  }) async {
    try {
      if (!await ConnectivityHelper.connected) {
        return const Left(NetworkFailure(AppStrings.checkInternetConnection));
      }
      final url = '${AppUrls.updateStatusOrder}$orderId';
      log('Calling URL: $url'); // Check the actual URL

      // final result = await apiService.post(
      //   url,
      //   data: request.toJson(),
      // );
      final result = await apiService.put(
        url,
        data: request.toJson(),
      );
      log('Request body: ${request.toJson()}');

      log('Update Order Status Response: $result');

      return Right(UpdateStatusOrderResponseModel.fromJson(result));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
