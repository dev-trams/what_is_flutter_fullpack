class AduinoDataModel {
  final String id;
  final int sensor_status;

  AduinoDataModel({required this.id, required this.sensor_status});

  factory AduinoDataModel.formJson(Map<String, dynamic> json) {
    return AduinoDataModel(
      id: json['id'],
      sensor_status: json['sensor_status'],
    );
  }
}
