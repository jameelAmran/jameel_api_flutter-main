import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../utils/constants.dart';

class ApiService {
  final dio.Dio _dio = dio.Dio();

  ApiService() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  Future<dio.Response<dynamic>> postData(String data) async {
    try {
      final response = await _dio.post(
        ApiConstants.dataEndpoint,
        data: {'data': data},
      );
      return response;
    } on dio.DioException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      rethrow;
    }
  }
}