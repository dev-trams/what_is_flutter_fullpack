// ignore_for_file: lines_longer_than_80_chars

import 'package:frogging/database/model.dart';
import 'package:frogging/database/sql_client.dart';

/// data source from MySQL
class DataSource {
  /// initializing
  const DataSource(this.sqlClient);

  /// Retrieves a single row from the database based on the given id
  Future<DatabaseModel?> read(String id) async {
    // SQL query
    const sqlQuery = 'SELECT * FROM iot_sample WHERE id = :id;';
    try {
      // Execute the query with parameters
      final result = await sqlClient.query(sqlQuery, parmeters: {'id': id});

      // Check if the result is not empty
      if (result.isNotEmpty) {
        // Return the first row
        return DatabaseModel.fromRowAssoc(result.first);
      } else {
        // If the result is empty, return null
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<DatabaseModel> create(DatabaseModel iot) async {
    const sqlQuery =
        'INSERT INTO iot_sample (id, sensor_status) VALUES (:id, :sensor_status);';
    try {
      final result = await sqlClient.execute(
        sqlQuery,
        params: {
          'id': iot.id,
          'sensor_status': iot.sensorStatus,
        },
      );
      if (result.isNotEmpty) {
        return DatabaseModel.fromRowAssoc(result.first as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error: $e');
      return const DatabaseModel();
    }
    return const DatabaseModel();
  }

  Future<DatabaseModel> update(String id, DatabaseModel iot) async {
    const sqlQuery =
        'UPDATE iot_sample SET sensor_status = :sensor_status WHERE id  = :id;';
    try {
      final result = await sqlClient.query(
        sqlQuery,
        parmeters: {'id': id, 'sensor_status': iot.sensorStatus},
      );
      if (result.isNotEmpty) {
        return DatabaseModel.fromRowAssoc(result.first);
      }
    } catch (e) {
      print('Error $e');
      return const DatabaseModel();
    }
    return const DatabaseModel();
  }

  /// Fetches all records from the database //! readALL
  Future<List<DatabaseModel>> fetchFields() async {
    // SQL query
    const sqlQuery = 'SELECT * FROM iot_sample;';
    try {
      // Execute the query
      final result = await sqlClient.query(sqlQuery);
      // Convert rows to DatabaseModel objects
      final users = result.map(DatabaseModel.fromRowAssoc).toList();

      return users;
    } catch (e) {
      print('Error: $e');
      // If an error occurs, return an empty list
      return [];
    }
  }

  /// Accessing the MySQL client
  final MySQLClient sqlClient;
}
