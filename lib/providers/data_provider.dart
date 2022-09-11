/// Provider page for binding view and model. This page includes business logic.

import 'package:artivatic_mt/models/canada_data.dart';
import 'package:artivatic_mt/utils/network_utils.dart';
import 'package:artivatic_mt/web_services/api_response.dart';
import 'package:artivatic_mt/web_services/webservices.dart';
import 'package:flutter/material.dart';

class PostDataProvider with ChangeNotifier {
  CanadaApiResponse post = CanadaApiResponse();
  List<DataRows>? dataList;
  bool loading = true;
  late bool networkNotAvailable;
  final controller = TextEditingController();
  String _searchString = "";

  /// This future function awaits for api response and updates the UI.
  Future<void> getPostData(context) async {
    loading = true;
    notifyListeners();
    int status = await NetworkUtils().isNetworkAvailable();
    if (status != 0 && status == 1) {
      networkNotAvailable = false;
      try {
        post = await WebServices().getResponsePostData(context);
        loading = false;
        _searchString = "";
        controller.clear();
      } catch (e) {
        loading = false;
      }
    } else {
      networkNotAvailable = true;
      loading = false;
    }
    notifyListeners();
  }

  /// Filter searched item with title of the list and returns the value.
  List<DataRows>? get data => _searchString.isEmpty
      ? post.rows
      : post.rows
          ?.where((element) =>
              element.title != null &&
              element.title!
                  .toLowerCase()
                  .contains(_searchString.toLowerCase()))
          .toList();

  /// Function to implement simple search functionality.
  void changeSearchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
  }
}
