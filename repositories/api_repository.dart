import '../models/data_model.dart';
import '../services/api_service.dart';

class ApiRepository {
  final ApiService _apiService = ApiService();

  Future<void> sendDataToApi(DataModel data) async {
    await _apiService.postData(data.data);
  }
}