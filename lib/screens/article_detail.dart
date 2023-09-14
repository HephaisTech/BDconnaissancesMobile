import 'package:bdconnaissance/controller/articlectrl.dart';
import 'package:bdconnaissance/models/article.dart';
import 'package:bdconnaissance/models/comment.dart';
import 'package:bdconnaissance/utils/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nil/nil.dart';
import 'package:ready/ready.dart';

class ArticleDetail extends ConsumerStatefulWidget {
  const ArticleDetail(this.article, {super.key});
  final Article article;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends ConsumerState<ArticleDetail> {
  final articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    articleController.getArticleComments(widget.article.id);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Get.size * 0.20,
          child: GestureDetector(
            onPanUpdate: (details) {},
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      child: Animated(
                        fade: const FadeAnimation(),
                        transforms: const [
                          ScaleAnimation.y(),
                          FlipAnimation(FlipType.x),
                        ],
                        child: nil,
                      ),
                    ),
                  ),
                  Text(
                    widget.article.title.tr,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: articleController.listArticleComment.length,
          itemBuilder: (context, index) {
            Commentaire commentaire =
                articleController.listArticleComment.value[index];
            return ListTile(
              title: Text(commentaire.content),
            );
          },
        )),
      ),
    ));
  }
}
