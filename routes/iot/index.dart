import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:frogging/database/model.dart';
import 'package:frogging/source/data_source.dart';

// we will create a request to read our dataSource
Future<Response> onRequest(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, dataSource);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, DataSource dataSource) async {
  // reading the context of our dataSource
  // based on that we will await and fetch the fields from our database
  final users = await dataSource.fetchFields();
  // than we will return the response as JSON
  return Response.json(body: users);
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<DataSource>();
  final iot = DatabaseModel.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  return Response.json(
    statusCode: HttpStatus.created,
    body: await dataSource.create(iot),
  );
}
