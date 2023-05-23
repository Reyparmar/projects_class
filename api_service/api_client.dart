import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:indoshyam/repository/api_service/api_methods.dart';

class ApiClient {
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  static const baseUrl = 'http://indoshyamapi.digitalerp.biz/api/';

  Future<String> getMethod({
    required String method,
    Map<String, String>? header,
  }) async {
    try {
      log(method);
      if (header != null) {
        log(header.toString());
      }
      final response = await http.get(
        Uri.parse('$baseUrl$method'),
        headers: header,
      );
      log(response.body);
      return response.body;
    } catch (e) {
      log('______ getMethode error ${e.toString()}');
      return '';
    }
  }

  Future<String> patchMethod({
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    try {
      log(method);
      if (header != null) {
        log(header.toString());
      }
      if (body != null) {
        log(body.toString());
      }
      final response =
          await http.patch(Uri.parse('$baseUrl$method'), headers: header, body: jsonEncode(body));
      log(response.body);
      return response.body;
    } catch (e) {
      log('______ getMethode error ${e.toString()}');
      return '';
    }
  }

  Future<String> getQueryMethod({
    required String method,
    required Map<String, String> query,
    required Map<String, String> header,
  }) async {
    try {
      String authority = ApiMethods.domain.replaceAll('https://', '');
      authority = authority.replaceAll('/', '');
      var uri = Uri.https(authority, method, query);
      log('$uri');
      final response = await http.get(uri, headers: header);
      log(response.body);
      return response.body;
    } catch (e) {
      log('______ getMethode error ${e.toString()}');
      return '';
    }
  }

  Future<String> postMethod({
    required method,
    required Map<String, String> body,
    Map<String, String>? header,
  }) async {
    try {
      log('$baseUrl$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      final response = await http.post(
        Uri.parse('$baseUrl$method'),
        body: body,
        headers: header,
      );
      log(response.body);
      return response.body;
    } catch (e) {
      log('______ post Method error ${e.toString()}');
      return '';
    }
  }

  Future<String> postMultipartMethod({
    required method,
    required Map<String, String> body,
    required Map<String, String> header,
    required List<File> files,
    required String field,
  }) async {
    try {
      Uri uri = Uri.parse(method);
      log(uri.toString());
      log(body.toString());
      var multiRequest = http.MultipartRequest(
        "Post",
        Uri.parse(
          '$baseUrl$method',
        ),
      );
      multiRequest.headers.addAll(header);
      multiRequest.fields.addAll(body);
      files.forEach(
        (element) async {
          multiRequest.files.add(
            await http.MultipartFile.fromPath(
              field,
              element.path,
            ),
          );
        },
      );
      http.Response response = await http.Response.fromStream(
        await multiRequest.send(),
      );
      log(response.body.toString());
      return response.body;
    } catch (e) {
      log('______ post Multipart Method error ${e.toString()}');
      return '';
    }
  }
}
