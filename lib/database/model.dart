/// Model based on you table inside MySQL

// ignore_for_file: public_member_api_docs

/*

Your database model - forExample

you created a database name profiles AND it has a table
called users and users have have rows and column you create
this model based on your fields inside you table



*/

class DatabaseModel {
  const DatabaseModel({
    this.id,
    this.sensorStatus,
  });
  // fromJSON
  factory DatabaseModel.fromJson(Map<String, dynamic> json) {
    return DatabaseModel(
      id: json['id'] as String,
      sensorStatus: json['sensor_status'] as int,
    );
  }

  // Create an DatabaseModel given a row.assoc() map
  factory DatabaseModel.fromRowAssoc(Map<String, dynamic> json) {
    return DatabaseModel(
      id: json['id'] as String,
      sensorStatus: json['sensor_status'] as int,
    );
  }
  DatabaseModel copyWith({String? id, int? sensorStatus}) {
    return DatabaseModel(
      id: id ?? this.id,
      sensorStatus: sensorStatus ?? this.sensorStatus,
    );
  }

  // toJSON
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'sensor_status': sensorStatus,
    };
  }

  final String? id;
  final int? sensorStatus;
}
