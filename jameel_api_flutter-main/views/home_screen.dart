import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';

class HomeScreen extends StatelessWidget {
  final DataController _dataController = Get.put(DataController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Online Sync'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter Data',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // مسافة بين العناصر

            // زر إرسال البيانات
            ElevatedButton(
              onPressed: () async {
                if (_textController.text.isNotEmpty) {
                  await _dataController.addData(_textController.text);
                  _textController.clear(); // مسح حقل النص بعد الإرسال
                  Get.snackbar('Success', 'Data added successfully!');
                } else {
                  Get.snackbar('Error', 'Please enter some data.');
                }
              },
              child: Text('Send Data'),
            ),

            SizedBox(height: 20), // مسافة بين العناصر

            // عرض البيانات المعلقة
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _dataController.pendingData.length,
                  itemBuilder: (context, index) {
                    final data = _dataController.pendingData[index];
                    return ListTile(
                      title: Text(data.data),
                    );
                  },
                );
              }),
            ),

            // زر مزامنة البيانات
            ElevatedButton(
              onPressed: () async {
                await _dataController.syncData();
                Get.snackbar('Success', 'Data synced successfully!');
              },
              child: Text('Sync Data'),
            ),
          ],
        ),
      ),
    );
  }
}