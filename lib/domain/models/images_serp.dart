import 'dart:convert';

import 'package:http/http.dart' as http;


class YandexImage {

  List<ImagesResults>? imagesResults;

  YandexImage(
      {
        this.imagesResults,
      });

  YandexImage.fromJson(Map<String, dynamic> json) {

    if (json['images_results'] != null) {
      imagesResults = <ImagesResults>[];
      json['images_results'].forEach((v) {
        imagesResults!.add(ImagesResults.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};


    if (imagesResults != null) {
      data['images_results'] =
          imagesResults!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class ImagesResults {
  String? thumbnail;

  String? original;
  Size? size;

  ImagesResults(
      {this.thumbnail,

        this.original,
        this.size});

  ImagesResults.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];

    original = json['original'];

    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;

    data['original'] = original;
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class Size {
  int? height;
  int? width;
  int? bytes;

  Size({this.height, this.width, this.bytes});

  Size.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    bytes = json['bytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['width'] = width;
    data['bytes'] = bytes;
    return data;
  }
}

class SerpapiPagination {
  String? next;
  String? current;

  SerpapiPagination({this.next, this.current});

  SerpapiPagination.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['current'] = current;
    return data;
  }
}


Future<YandexImage> getImages(String query, ) async{
  Uri url = Uri.parse('https://serpapi.com/search.json?engine=yandex_images&text=$query&api_key=ed83d23665c395ad2e7ebd2d718509158f8226f0053b8ac268af8451caaa9d0e');
  final response = await http.get(url);

  if (response.statusCode == 200) {

    return YandexImage.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error ${response.statusCode}');
  }

}