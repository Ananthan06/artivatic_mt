/// Webservice class , this module api fetch and error handling.

import 'dart:convert';
import 'dart:developer';
import 'package:artivatic_mt/web_services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebServices {
  static const String url =
      "https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf";

  ///Function to call api request and get data and handle error.
  Future<dynamic> getResponsePostData(context) async {
    try {
      final response = await http.get(Uri.parse(url));
      var statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || statusCode == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error in webservice"),
        ));
      } else {
        return CanadaApiResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
