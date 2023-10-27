// ignore_for_file: avoid_shadowing_type_parameters

import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:domain/models/http_request.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:infrastructure/interfaces/ihttp_provider_service.dart';

class HttpProvider implements IHttpProviderService {
  String? sessionToken;
  List<int> cIds = [];

  @override
  Future<String?> getRequest(
    HttpRequest request, {
    bool isAuthenticated = false,
    String tokenType = "auth-token",
    String header = "authorization",
    String prefix = "Bearer ",
  }) async {
    try {
      request = await checkAuthStatus(
        isAuthenticated,
        request,
        tokenType,
        header,
        prefix,
      );

      final response =
          await http.get(Uri.parse(request.url), headers: request.headers);

      if (response.statusCode == 200) {
        return response.body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> postRequest(
    HttpRequest request, {
    bool isAuthenticated = false,
    String tokenType = "auth-token",
    String header = "authorization",
    String prefix = "Bearer ",
    bool dontCast = false,
  }) async {
    try {
      request = await checkAuthStatus(
        isAuthenticated,
        request,
        tokenType,
        header,
        prefix,
      );

      var result = await http.post(
        Uri.parse(request.url),
        headers: request.headers,
        body: request.params != null ? jsonEncode(request.params) : null,
      );

      if (result.statusCode == 200) {
        return result.body;
      }
      print(result.body);

      return null;
    } catch (ex) {
      print(ex);

      return null;
    }
  }

  @override
  Future<String?> putReqest(
    HttpRequest request, {
    bool isAuthenticated = false,
    String tokenType = "auth-token",
    String header = "authorization",
    String prefix = "Bearer ",
  }) async {
    try {
      request = await checkAuthStatus(
        isAuthenticated,
        request,
        tokenType,
        header,
        prefix,
      );

      var result = await http.put(
        Uri.parse(request.url),
        headers: request.headers,
        body: jsonEncode(request.params),
      );

      if (result.statusCode == 200) {
        return result.body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<HttpRequest> checkAuthStatus(
    bool isAuthenticated,
    HttpRequest request,
    String tokenType,
    String header,
    String prefix,
  ) async {
    return request;
  }

  String createCryptoRandomString([int length = 128]) {
    var random = Random.secure();

    var values = List<int>.generate(length, (i) => random.nextInt(256));

    return base64ToHex(base64Encode(values));
  }

  String base64ToHex(String source) =>
      base64Decode(LineSplitter.split(source).join())
          .map((e) => e.toRadixString(16).padLeft(2, '0'))
          .join();

  getPublicKey() async {
    return await rootBundle.loadString('packages/domain/assets/user_token.pub');
  }

  validateAccessToken(String token) async {
    var certificate = await getPublicKey();
    JWT? verify = JWT.tryVerify(token, RSAPublicKey(certificate));
    if (verify != null) {
      var payload = verify.payload as Map<String, dynamic>;
      var existing = payload['access'] as List<dynamic>;
      existing.map((e) => cIds.add(e)).toList();
    }
  }

  @override
  void setToken(String token, value) {
    // TODO: implement setToken
  }
}
