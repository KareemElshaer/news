import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/newsresponse.dart';
import 'package:news/model/sourcerecponse.dart';

class ApiManger {
  /*
  https://newsapi.org/v2/top-headlines/sources?apiKey=14b1fa8a0cea409d94b8a3bffa2d57da
   */
  static Future<Sourcerecponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.apiname, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return Sourcerecponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<Newsresponse> getnewsSources(
    String? id,
    String text,
    int? page,
  ) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsname, {
      'apiKey': ApiConstants.apiKey,
      'sources': id,
      'q': text,
      'page': page.toString(),
    });

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return Newsresponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}

/*
https://newsapi.org/v2/everything?q=bitcoin&apiKey=14b1fa8a0cea409d94b8a3bffa2d57da
 */
