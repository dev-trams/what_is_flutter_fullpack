import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frogging/database/model.dart';
import 'package:frogging/source/data_source.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String id,
) async {
  print(context.request.uri.path);
  if (context.request.uri.path == '/iot') {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final dataSource = context.read<DataSource>();
  final iot = await dataSource.read(id);
  if (iot == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, dataSource, id);
    case HttpMethod.put:
      return _put(context, id, iot, dataSource);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(
  RequestContext context,
  DataSource dataSource,
  String id,
) async {
  // based on that we will await and fetch the fields from our database
  final users = await dataSource.read(id);
  // than we will return the response as JSON
  return Response.json(body: users);
}

Future<Response> _put(
  RequestContext context,
  String id,
  DatabaseModel iot,
  DataSource dataSource,
) async {
  try {
    // Parse the request body into a JSON object
    final requestBody = await context.request.body();
    final bodyString = requestBody;
    if (bodyString.isEmpty) {
      throw const FormatException('Empty Request Body');
    }
    final dynamic json = jsonDecode(bodyString);
    final sensorStatus = json['sensor_status'] as int;
    // Create a new DatabaseModel instance from the JSON object
    final newIot = iot.copyWith(sensorStatus: sensorStatus);
    final updata = await dataSource.update(id, newIot);
    // Return the updated DatabaseModel as JSON response
    return Response.json(
      body: updata,
    );
  } catch (e) {
    print('Error parsing JSON: $e');
    return Response(body: 'Failed to parse JSON');
  }
}
