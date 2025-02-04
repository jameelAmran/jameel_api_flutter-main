class DataModel {
  int? id;
  String data;

  DataModel({this.id, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'],
      data: map['data'],
    );
  }
}