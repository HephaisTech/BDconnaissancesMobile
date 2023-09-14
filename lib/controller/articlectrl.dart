import 'dart:convert';

import 'package:bdconnaissance/models/article.dart';
import 'package:bdconnaissance/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ArticleController extends GetxController {
  var listArticles = [].obs;

  void getArticleListe() async {
    debugPrint('ok');
    var token = '6|zzYnHxjrpy2HjBFeLEOrbu14PZ9Uw1OBa2qHM389';
    // App.getStorage.read('BDUSERKEY');
    final response = await http.get(
      Uri.parse('$baseUrl/articles'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List jsdata = jsonData['data'];
      listArticles.value =
          jsdata.map((item) => Article.fromJson(item)).toList();
    } else {
      listArticles.value = [];
      debugPrint('${response.statusCode}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('onInit');
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('onReady');
    getArticleListe();
  }
}
