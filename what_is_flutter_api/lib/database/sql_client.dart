import 'dart:ffi';

import 'package:mysql_client/mysql_client.dart';

/// creating a database connection with MySQL
class MySQLClient {
  /// Returns a singleton
  factory MySQLClient() {
    return _inst;
  }

  MySQLClient._internal() {
    _connect();
  }

  static final MySQLClient _inst = MySQLClient._internal();

  MySQLConnection? _connection;

  /// initializes a connection to database
  Future<void> _connect() async {
    _connection = await MySQLConnection.createConnection(
      // "localhost" OR 127.0.0.1
      host: 'ctrls-studio.com',
      // Your MySQL port
      port: 3306,
      // MySQL userName
      userName: 'writer',
      // MySQL Database password
      password: 'writerserver@0422',
      // your database name
      databaseName: 'core',
      // false - if your are not using SSL - otherwise it will through an error
      secure: false,
    );
    await _connection?.connect();
  }

  ///execute a given query and checks for db connection
  Future<IResultSet> execute(
    String query, {
    Map<String, dynamic>? params,
    bool iterable = false,
  }) async {
    if (_connection == null || _connection?.connected == false) {
      await _connect();
    }

    if (_connection?.connected == false) {
      throw Exception('Could not connect to the database');
    }
    return _connection!.execute(query, params, iterable).whenComplete(
          () => print('query: $query | params: $params | iterable: $iterable'),
        );
  }

  Future<List<Map<String, dynamic>>> query(
    String sql, {
    Map<String, dynamic>? parmeters,
  }) async {
    try {
      final result = await execute(sql, params: parmeters);
      final rows = <Map<String, dynamic>>[];
      for (final row in result.rows) {
        print(row.typedAssoc());
        rows.add(row.typedAssoc());
      }
      return rows;
    } catch (e) {
      print('Query error: $e');
      throw Exception('Failed to execute query');
    }
  }
}
