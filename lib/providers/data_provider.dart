/// Provider page for binding view and model. This page includes business logic.

import 'package:artivatic_mt/models/canada_data.dart';
import 'package:artivatic_mt/web_services/api_response.dart';
import 'package:artivatic_mt/web_services/webservices.dart';
import 'package:flutter/material.dart';

class PostDataProvider with ChangeNotifier {
  CanadaApiResponse post = CanadaApiResponse();
  List<DataRows>? dataList;
  bool loading = true;

  /// This future function awaits for api response and updates the UI.
  Future<void> getPostData(context) async {
    loading = true;
    post = await WebServices().getResponsePostData(context);
    loading = false;
    notifyListeners();
  }

}
