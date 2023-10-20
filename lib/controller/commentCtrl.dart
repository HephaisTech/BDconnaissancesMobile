import 'dart:convert';

import 'package:bdconnaissance/models/comment.dart';
import 'package:bdconnaissance/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentCtrl extends GetxController {
  var commentList = <Commentaire>[].obs;

  void getArticleComments(int idArticle) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/article/$idArticle'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> jsdata = jsonData['data'];
      commentList
          .assignAll(jsdata.map((item) => Commentaire.fromJson(item)).toList());
    } else {
      commentList.clear();
      debugPrint('${response.statusCode}');
    }
  }

  Future<List<Commentaire>> getCommentResponses(int parentid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/responses/$parentid'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> jsdata = jsonData['data'];
      return jsdata.map((item) => Commentaire.fromJson(item)).toList();
    } else {
      debugPrint('${response.statusCode}');
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('CommentCtrl.onInit');
  }
}
