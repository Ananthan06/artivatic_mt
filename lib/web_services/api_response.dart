/// json converted class for api response

import 'package:artivatic_mt/models/canada_data.dart';

class CanadaApiResponse {
  String? title;
  List<DataRows>? rows;

  CanadaApiResponse({this.title, this.rows});

  CanadaApiResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['rows'] != null) {
      rows = <DataRows>[];
      json['rows'].forEach((v) {
        rows!.add( DataRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
