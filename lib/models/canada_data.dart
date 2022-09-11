/// Generated data class from given api response

class DataRows {
  String? title;
  String? description;
  String? imageHref;

  DataRows({this.title, this.description, this.imageHref});

  DataRows.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageHref = json['imageHref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['imageHref'] = imageHref;
    return data;
  }
}
