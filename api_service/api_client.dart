import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mate/app_route/app_router.dart';
import 'package:mate/repository/api_service/api_methods.dart';
import 'package:mate/repository/chat_service/firestore_service.dart';
import 'package:mate/repository/model/firebase_crash_data.dart';
import 'package:mate/src/utils/app_extentions.dart';
import 'package:mate/src/utils/constants.dart';
import 'package:mate/src/utils/show_message.dart';

class ApiClient {
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  Future<String> getMethod({
    required String method,
    Map<String, String>? header,
  }) async {
    try {
      log('$method');
      if (header != null) {
        log(header.toString());
      }
      final response = await http.get(
        Uri.parse('$method'),
        headers: header,
      );
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'get',
          requestUrl: method,
          requestHeader: header,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ getMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> patchMethod({
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    try {
      log('$method');
      if (header != null) {
        log(header.toString());
      }
      if (body != null) {
        log(body.toString());
      }
      final response = await http.patch(Uri.parse('$method'), headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'patch',
          requestUrl: method,
          requestHeader: header,
          requestParam: body,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ patchMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> getQueryMethod({
    required String method,
    required Map<String, String> query,
    required Map<String, String> header,
  }) async {
    try {
      String authority = ApiMethods.DOMAIN.replaceAll('https://', '');
      authority = authority.replaceAll('/', '');
      var uri = Uri.https(authority, method, query);
      log('$uri');
      final response = await http.get(uri, headers: header);
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'getQuery',
          requestUrl: uri.toString(),
          requestHeader: header,
          requestParam: query,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ getQueryMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> postMethod({
    required method,
    required Map<String, String> body,
    Map<String, String>? header,
  }) async {
    try {
      log('$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      final response = await http.post(
        Uri.parse('$method'),
        body: jsonEncode(body),
        headers: header,
      );
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'post',
          requestUrl: method,
          requestHeader: header,
          requestParam: body,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ postMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> postMultipartMethod({
    required method,
    required Map<String, String> body,
    required Map<String, String> header,
    required List<File> files,
  }) async {
    try {
      Uri uri = Uri.parse(method);
      log(uri.toString());
      log(body.toString());
      var multiRequest = await http.MultipartRequest(
        "Post",
        Uri.parse(
          '$method',
        ),
      );
      multiRequest.headers.addAll(header);
      multiRequest.fields.addAll(body);
      files.forEach(
        (element) async {
          multiRequest.files.add(
            await http.MultipartFile.fromPath(
              'image',
              element.path,
            ),
          );
        },
      );
      http.Response response = await http.Response.fromStream(
        await multiRequest.send(),
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'postMultipart',
          requestUrl: method,
          requestHeader: header,
          requestParam: body,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body.toString());
        return response.body;
      }
    } catch (e) {
      log('______ postMultipartMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> putMethod({
    required method,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    try {
      log('$method');
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      final response = await http.put(
        Uri.parse('$method'),
        body: jsonEncode(body),
        headers: header,
      );
      if (response.statusCode == 200) {
        log(response.body.toString());
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'put',
          requestUrl: method,
          requestHeader: header,
          requestParam: body,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ putMethod error ${e.toString()}');
      return '';
    }
  }

  Future<String> deleteMethod({
    required method,
    required Map<String, String> header,
  }) async {
    try {
      log('$method');
      log(header.toString());
      final response = await http.delete(
        Uri.parse('$method'),
        headers: header,
      );
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else if (response.statusCode == 401) {
        ShowMessage.toast(msg: AppString.sessionExpired);
        router.go(loginView);
        logoutCall();
        return response.body;
      } else {
        var crashData = FirebaseCrashData(
          time: DateTime.now(),
          requestType: 'delete',
          requestUrl: method,
          requestHeader: header,
          requestResponseBody: response.body.toString(),
          requestResponseCode: response.statusCode,
        );
        FireStoreService.instance.sendCrashReport(
          firebaseCrashData: crashData,
        );
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log('______ deleteMethod error ${e.toString()}');
      return '';
    }
  }
}
