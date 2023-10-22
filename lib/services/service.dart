import 'dart:convert';

import 'package:brunohsp_app/services/http_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class Service {
  final http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  final Map<String, String> headers = {"Accept": "application/json"};
  static const String baseUrl = "https://www.dnd5eapi.co/api/";

  String getUrl(resource) {
    return "$baseUrl$resource";
  }

  Uri getUri(resource){
    return Uri.parse(getUrl(resource));
  }

  Future<Map<String, dynamic>> get(resource) async {
    http.Response response =
        await client.get(getUri(resource));

    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }

  Future<List<dynamic>> getList(resource) async {
    http.Response response =
        await client.get(getUri(resource));

    List<dynamic> data = json.decode(response.body);

    return data;
  }
}

