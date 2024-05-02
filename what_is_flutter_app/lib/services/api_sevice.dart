import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatisflutter/models/aduino_data_model.dart';

Future<void> createAduinoData({value_id, value_status}) async {
  var url = Uri.parse("http://core.apis.ctrls-studio.com/iot/");

  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {"id": value_id, "sensor_status": value_status},
      ),
    );

    if (response.statusCode == 201) {
      print('create success');
    } else {
      print(
        'create failed, Status code : ${response.statusCode}',
      );
    }
  } catch (e) {
    print('$e');
  }
}

Future<List<AduinoDataModel>> readAduinoData() async {
  List<AduinoDataModel> aduinoDataInstance = [];
  var url = Uri.parse("http://core.apis.ctrls-studio.com/iot");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      for (var result in jsonData) {
        var aduinoDataModel = AduinoDataModel.formJson(result);
        aduinoDataInstance.add(aduinoDataModel);
      }
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('$e');
  }
  return aduinoDataInstance;
}

Future<void> updateAduinoData({value_id, value_status}) async {
  var url = Uri.parse("http://core.apis.ctrls-studio.com/iot/$value_id");

  try {
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {"id": value_id, "sensor_status": value_status as int},
      ),
    );

    if (response.statusCode == 200) {
      print('update success');
    } else {
      print(
        'update failed, Status code : ${response.statusCode}',
      );
      print('$value_status');
    }
  } catch (e) {
    print('$e');
  }
}

Future<void> deleteAduinoData({value_id}) async {
  var url = Uri.parse("http://core.apis.ctrls-studio.com/iot/$value_id");
  try {
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      print('delete success');
    }
  } catch (e) {
    print('$e');
  }
}
