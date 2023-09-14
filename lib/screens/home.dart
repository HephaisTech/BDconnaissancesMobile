// ignore_for_file:, prefer_const_constructors
import 'dart:math';

import 'package:bdconnaissance/controller/articlectrl.dart';
import 'package:bdconnaissance/models/article.dart';
import 'package:bdconnaissance/screens/article_detail.dart';
import 'package:bdconnaissance/utils/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nil/nil.dart';
import 'package:ready/ready.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final articleController = Get.put(ArticleController());
  TextEditingController searchingController = TextEditingController();
  late AnimationController _animationController;
  var _searching = false.obs;
  var _sorting = true.obs;
  var _headshow = true.obs;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
                preferredSize:
                    _headshow.value ? Get.size * 0.18 : Get.size * 0.18,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    details.delta.dy > 0
                        ? _headshow.value = true
                        : _headshow.value = false;
                  },
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Animated(
                            fade: const FadeAnimation(),
                            transforms: const [
                              ScaleAnimation.y(),
                              FlipAnimation(FlipType.x),
                            ],
                            child: CachedNetworkImage(
                              imageUrl: '', // user profil
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 100,
                              ),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 100,
                              ),
                              errorWidget: (context, url, error) {
                                return CircleAvatar(
                                  radius: 100,
                                  child: IconButton(
                                      onPressed: () {
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            // message: 'No illustration'.tr,
                                            messageText: Text(
                                              'No illustration'.tr,
                                              style: GoogleFonts.poppins(
                                                color: App.backgroundColor,
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: App.backgroundColor,
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                          ),
                                        );
                                      },
                                      icon: Icon(FontAwesomeIcons.image)),
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Ramius'.tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                child: _sorting.value
                                    ? Icon(CupertinoIcons.sort_down)
                                    : Icon(CupertinoIcons.sort_up),
                                onTap: () async {
                                  _sorting.toggle();
                                },
                              ),
                            ),
                            _searching.value
                                ? SizedBox(
                                    width: Get.width * 0.8,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: searchingController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          hintText: "Search".tr,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            size: 20,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          //recherche
                                          if (value != '') {
                                            articleController
                                                    .listArticles.value =
                                                articleController
                                                    .listArticles.value
                                                    .where((el) => el.title
                                                        .toLowerCase()
                                                        .contains(value
                                                            .toLowerCase()))
                                                    .toList();
                                          } else {
                                            articleController.getArticleListe();
                                            _searching.value = false;
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.search_ellipsis,
                                  progress: _animationController,
                                ),
                                onTap: () async {
                                  _searching.toggle();
                                  _searching.value
                                      ? _animationController.forward()
                                      : _animationController.reverse();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: articleController.listArticles.isEmpty
                      ? _searching.value == true
                          ? Nodata()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  semanticsLabel: 'loading'.tr,
                                  strokeWidth: 2,
                                  color: App.loaderColor,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Reload'.tr,
                                    ))
                              ],
                            )
                      : Entry.all(
                          child: ArticleListview(),
                          duration: Duration(seconds: 1),
                        )),
            ),
          ),
        ));
  }
}

class Nodata extends StatelessWidget {
  const Nodata({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                Get.reload();
              },
              icon: Icon(FontAwesomeIcons.accessibleIcon)),
          Material(
              child: Text(
            'No match Topic'.tr,
            style: GoogleFonts.poppins(),
          ))
        ],
      ),
    );
  }
}

//liste of Articles

class ArticleListview extends StatelessWidget {
  const ArticleListview({super.key});

  @override
  Widget build(BuildContext context) {
    final articleController = Get.put(ArticleController());

    return ListView.builder(
      shrinkWrap: true,
      itemCount: articleController.listArticles.value.length,
      itemBuilder: (context, index) {
        Article article = articleController.listArticles.value[index];
        return Card(
          elevation: 5,
          child: ListTile(
            isThreeLine: true,
            title: Text(
              article.title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              article.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: GoogleFonts.poppins(
                fontSize: 10,
              ),
            ),
            leading: Animated(
              fade: const FadeAnimation(),
              transforms: const [
                ScaleAnimation.y(),
                FlipAnimation(FlipType.x),
              ],
              child: CachedNetworkImage(
                imageUrl: article.withfile,
                width: 50,
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 100,
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 100,
                ),
                errorWidget: (context, url, error) {
                  return CircleAvatar(
                    radius: 100,
                    child: IconButton(
                        onPressed: () {
                          Get.showSnackbar(
                            GetSnackBar(
                              // message: 'No illustration'.tr,
                              messageText: Text(
                                'No illustration'.tr,
                                style: GoogleFonts.poppins(
                                  color: App.backgroundColor,
                                ),
                              ),
                              icon: Icon(
                                Icons.image_not_supported_outlined,
                                color: App.backgroundColor,
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        },
                        icon: Icon(FontAwesomeIcons.image)),
                  );
                },
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    print('Button Pressed');
                  },
                  child: Text(
                    DateFormat.yMd().format(article.createdAt),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //call your onpressed function here
                    print('Button Pressed');
                  },
                  child: article.commentCount > 0
                      ? Badge(
                          label: Text(
                            article.commentCount.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.white),
                          ),
                          child: Icon(
                            CupertinoIcons.bubble_left,
                            size: 20,
                          ),
                        )
                      : Icon(
                          CupertinoIcons.plus_bubble,
                          size: 20,
                        ),
                ),
              ],
            ),
            onTap: () {
              debugPrint(article.title);
              Get.to(() => ArticleDetail(article),
                  duration: Duration(seconds: 1));
            },
          ),
        );
      },
    );
  }
}

//  trailing: Column(
//               children: [
//                 article.commentCount > 0
//                     ? Badge(
//                         label: Text(article.commentCount.toString()),
//                         child: Icon(CupertinoIcons.bubble_left_bubble_right),
//                       )
//                     : nil,
//               ],
//             ),

//  MaterialButton(
//                     onPressed: () {
//                       Get.locale == Locale('en', 'US')
//                           ? Get.updateLocale(Locale('fr', 'FR'))
//                           : Get.updateLocale(Locale('en', 'US'));
//                     },
//                     child: Text('Base_de_Connaissances'.tr),
//                   ),

// AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               centerTitle: true,
//               actions: [],
//               title: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   child: CircleAvatar(
//                     radius: 30.0,
//                     backgroundImage: NetworkImage(App.imgplaceholder),
//                     backgroundColor: Colors.transparent,
//                   ),
//                 ),
//               ),
//               bottom: PreferredSize(
//                   preferredSize: Size.fromHeight(50),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: GestureDetector(
//                           child: _sorting.value
//                               ? Icon(CupertinoIcons.sort_down)
//                               : Icon(CupertinoIcons.sort_up),
//                           onTap: () async {
//                             _sorting.toggle();
//                           },
//                         ),
//                       ),
//                       _searching.value
//                           ? SizedBox(
//                               width: Get.width * 0.8,
//                               height: 50,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextField(
//                                   controller: searchingController,
//                                   decoration: InputDecoration(
//                                     contentPadding:
//                                         EdgeInsets.symmetric(vertical: 7.0),
//                                     hintText: "Search".tr,
//                                     prefixIcon: Icon(
//                                       Icons.search,
//                                       size: 20,
//                                     ),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(30.0)),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : SizedBox(),
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: GestureDetector(
//                           child: AnimatedIcon(
//                             icon: AnimatedIcons.search_ellipsis,
//                             progress: _animationController,
//                           ),
//                           onTap: () async {
//                             _searching.toggle();
//                             _searching.value
//                                 ? _animationController.forward()
//                                 : _animationController.reverse();
//                           },
//                         ),
//                       ),
//                     ],
//                   )),
//             ),

// appBar: PreferredSize(
//             preferredSize:
//                 _headshow.value ? Get.size * 0.23 : Get.size * 0.20,
//             child: GestureDetector(
//               onPanUpdate: (details) {
//                 details.delta.dy > 0
//                     ? _headshow.value = true
//                     : _headshow.value = false;
//               },
//               child: Card(
//                 child: Column(
//                   children: [
//                     _headshow.value
//                         ? Animated(
//                             fade: const FadeAnimation(),
//                             transforms: const [
//                               ScaleAnimation.y(),
//                               FlipAnimation(FlipType.x),
//                             ],
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(CupertinoIcons.globe),
//                                 ),
//                                 // IconButton(
//                                 //   onPressed: () {
//                                 //     _headshow.value = false;
//                                 //   },
//                                 //   icon: Icon(
//                                 //       CupertinoIcons.arrowtriangle_up_circle),
//                                 // ),
//                                 IconButton(
//                                   onPressed: () {
//                                     App.changeTheme();
//                                   },
//                                   icon: Icon(CupertinoIcons.sun_min),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [SizedBox()],
//                           ),
//                     SizedBox(
//                       height: 80,
//                       child: Animated(
//                         fade: const FadeAnimation(),
//                         transforms: const [
//                           ScaleAnimation.y(),
//                           FlipAnimation(FlipType.x),
//                         ],
//                         child: CachedNetworkImage(
//                           imageUrl: '', // user profil
//                           placeholder: (context, url) => const CircleAvatar(
//                             backgroundColor: Colors.amber,
//                             radius: 100,
//                           ),
//                           imageBuilder: (context, image) => CircleAvatar(
//                             backgroundImage: image,
//                             radius: 100,
//                           ),
//                           errorWidget: (context, url, error) {
//                             return CircleAvatar(
//                               radius: 100,
//                               child: IconButton(
//                                   onPressed: () {
//                                     Get.showSnackbar(
//                                       GetSnackBar(
//                                         // message: 'No illustration'.tr,
//                                         messageText: Text(
//                                           'No illustration'.tr,
//                                           style: GoogleFonts.poppins(
//                                             color: App.backgroundColor,
//                                           ),
//                                         ),
//                                         icon: Icon(
//                                           Icons.image_not_supported_outlined,
//                                           color: App.backgroundColor,
//                                         ),
//                                         duration: const Duration(seconds: 3),
//                                       ),
//                                     );
//                                   },
//                                   icon: Icon(FontAwesomeIcons.image)),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Ramius'.tr,
//                       style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: GestureDetector(
//                             child: _sorting.value
//                                 ? Icon(CupertinoIcons.sort_down)
//                                 : Icon(CupertinoIcons.sort_up),
//                             onTap: () async {
//                               _sorting.toggle();
//                             },
//                           ),
//                         ),
//                         _searching.value
//                             ? SizedBox(
//                                 width: Get.width * 0.8,
//                                 height: 50,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: TextField(
//                                     controller: searchingController,
//                                     decoration: InputDecoration(
//                                       contentPadding:
//                                           EdgeInsets.symmetric(vertical: 7.0),
//                                       hintText: "Search".tr,
//                                       prefixIcon: Icon(
//                                         Icons.search,
//                                         size: 20,
//                                       ),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(30.0)),
//                                       ),
//                                     ),
//                                     onChanged: (value) {},
//                                   ),
//                                 ),
//                               )
//                             : SizedBox(),
//                         Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: GestureDetector(
//                             child: AnimatedIcon(
//                               icon: AnimatedIcons.search_ellipsis,
//                               progress: _animationController,
//                             ),
//                             onTap: () async {
//                               _searching.toggle();
//                               _searching.value
//                                   ? _animationController.forward()
//                                   : _animationController.reverse();
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             )),
