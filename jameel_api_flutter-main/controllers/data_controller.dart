import 'package:get/get.dart';
import '../models/data_model.dart';
import '../repositories/api_repository.dart';
import '../repositories/local_repository.dart';

class DataController extends GetxController {
  final LocalRepository _localRepository = LocalRepository();
  final ApiRepository _apiRepository = ApiRepository();
  final RxList<DataModel> pendingData = <DataModel>[].obs;

  @override
  void onInit() {
    loadPendingData();
    super.onInit();
  }

  Future<void> addData(String data) async {
    final newData = DataModel(id: null, data: data);
    await _localRepository.insertData(newData);
    pendingData.add(newData);
  }

  Future<void> loadPendingData() async {
    pendingData.value = await _localRepository.getPendingData();
  }

  Future<void> syncData() async {
    for (var data in pendingData) {
      await _apiRepository.sendDataToApi(data);
      await _localRepository.deleteData(data.id!);
    }
    pendingData.clear();
  }
}
