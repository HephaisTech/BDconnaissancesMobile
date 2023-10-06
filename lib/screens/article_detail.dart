// ignore_for_file: invalid_use_of_protected_member, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bdconnaissance/controller/commentCtrl.dart';
import 'package:bdconnaissance/models/article.dart';
import 'package:bdconnaissance/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nil/nil.dart';

class ArticleDetail extends ConsumerStatefulWidget {
  const ArticleDetail(this.article, {super.key});
  final Article article;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends ConsumerState<ArticleDetail> {
  final commentaireController = Get.put(CommentCtrl());

  @override
  void initState() {
    super.initState();
    commentaireController.getArticleComments(widget.article.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: commentaireController.commentList.length,
                  itemBuilder: (context, index) {
                    Commentaire kcomment =
                        commentaireController.commentList.value[index];
                    return Card(
                      child: ExpansionTile(
                        subtitle: Text(kcomment.content),
                        title: Text(
                          kcomment.author.email,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        trailing: Column(
                          children: [
                            kcomment.withfile != ''
                                ? IconButton(
                                    onPressed: () {
                                      Get.dialog(Card(), useSafeArea: true);
                                    },
                                    icon: Icon(
                                      Icons.attach_file,
                                    ))
                                : Nil(),
                          ],
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 25,
                        ),
                        children: List.generate(
                            commentaireController.commentList.length, (index) {
                          Commentaire kchildcomment =
                              commentaireController.commentList.value[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Card(
                              child: ListTile(
                                title: Text(kchildcomment.content),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}
