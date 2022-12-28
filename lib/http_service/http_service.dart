import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:agro_sanoat/http_service/http_constant.dart';

class HttpService {
  static Future<Map<String, String>> getHeaders({password}) async {
    if (password!.isEmpty) {
      Box box = await Hive.openBox("db");
      String basicAuth = await box.get("auth") ?? "";
      return {
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Auth': basicAuth
      };
    } else {
      return {
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/json; charset=UTF-8',
        'Auth': password
      };
    }
  }

  static GET(url, {params, String? password}) async {
    try {
      Map<String, String>? headers;
      await getHeaders(password: password ?? "").then((value) {
        headers = value;
      });

      var response = await http.get(
        Uri.http(HttpConstant.mainUrl, url, params),
        headers: headers,
      );
      if (response.statusCode < 299) {
        var data = {
          'status': HttpConnection.data,
          'data': jsonDecode(response.body)
        };
        return data;
      } else {
        var data = {
          'status': HttpConnection.error,
          'data': jsonDecode(response.body)
        };

        return data;
      }
    } catch (e) {
      var data = {
        'status': HttpConnection.none,
        'data': {'message': "Internet not found"}
      };

      return data;
    }
  }

  static POST(url, body, {params, String? password}) async {
    try {
      Map<String, String>? headers;
      await getHeaders(password: password ?? "").then((value) {
        headers = value;
      });

      var response = await http.post(
        Uri.http(HttpConstant.mainUrl, url, params),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 512) {
        var data = {
          'status': HttpConnection.none,
          'data':
              response.body.isNotEmpty ? jsonDecode(response.body) : response
        };
        return data;
      }
      if (response.statusCode < 299) {
        var data = {
          'status': HttpConnection.data,
          'data':
              response.body.isNotEmpty ? jsonDecode(response.body) : response
        };
        return data;
      } else {
        var data = {
          'status': HttpConnection.error,
          'data': jsonDecode(response.body)
        };

        return data;
      }
    } catch (e) {
      var data = {
        'status': HttpConnection.none,
        'data': {'message': "Internet not found"}
      };

      return data;
    }
  }
}

enum HttpConnection { data, none, error }
