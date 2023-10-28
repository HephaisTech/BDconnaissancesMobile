// ignore_for_file: invalid_use_of_protected_member, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bdconnaissance/controller/commentCtrl.dart';
import 'package:bdconnaissance/models/article.dart';
import 'package:bdconnaissance/models/comment.dart';
import 'package:bdconnaissance/models/tags.dart';
import 'package:bdconnaissance/utils/app.dart';
import 'package:flutter/cupertino.dart';
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
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  @override
  void initState() {
    super.initState();
    commentaireController.getArticleComments(widget.article.id);
  }

  @override
  void dispose() {
    commentaireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
          child: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.emoji_emotions_outlined),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              ),
              title: TextField(
                controller: _controller,
                maxLines: null,
                cursorColor: App.loaderColor,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  hintText: 'Type a comment'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(
              widget.article.title.toUpperCase(),
              maxLines: 2,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.file_copy_outlined),
                  text: 'Détails'.tr,
                ),
                Tab(
                  icon: Badge(
                      child: Icon(Icons.chat_outlined),
                      label: Text('${widget.article.commentCount}')),
                  text: 'Commentaires'.tr,
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        widget.article.withfile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.groups),
                        label: Text(
                          'Departement : ${widget.article.departement}',
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.label),
                        label: Text(
                          'Project : ${widget.article.project}',
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.article.tags.length,
                      itemBuilder: (context, index) {
                        Tag tagvi = widget.article.tags[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('${tagvi.name}')),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description : ${widget.article.content}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
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
                        return buildCommentCard(kcomment);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ));
    });
  }
}

Widget buildCommentCard(Commentaire comment) {
  final commentaireController = Get.put(CommentCtrl());
  var responseListe = [].obs;
  return Obx(
    () {
      return Card(
        child: ExpansionTile(
          subtitle: Column(
            children: [
              Text(
                comment.content,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (comment.withfile != '') {
                          Get.dialog(
                              Card(
                                child: Image.network(
                                  comment.withfile,
                                ),
                              ),
                              useSafeArea: true);
                        }
                      },
                      icon: Icon(
                        Icons.attach_file,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.message_outlined)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border)),
                  ],
                ),
              )
            ],
          ),
          title: Text(
            comment.author.email,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          trailing: Nil(),
          leading: const CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 25,
          ),
          onExpansionChanged: (value) async {
            if (value) {
              responseListe.value =
                  await commentaireController.getCommentResponses(comment.id);
            }
          },
          children: [
            if (responseListe.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: responseListe.value
                      .map((reply) => buildCommentCard(reply))
                      .toList(),
                ),
              ),
          ],
        ),
      );
    },
  );
}
