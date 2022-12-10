import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitverse/components/articlebodyhtmlwidget.dart';
import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/components/viewsarticledetail.dart';
import 'package:fitverse/model/contents.dart';
import 'package:fitverse/screen/bookingnow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class ArticleDatailAll extends StatefulWidget {
  final Article data;
  final String tag;
  const ArticleDatailAll({Key key, this.data, this.tag}) : super(key: key);

  @override
  State<ArticleDatailAll> createState() => _ArticleDatailAllState();
}

class _ArticleDatailAllState extends State<ArticleDatailAll> {
  FlickManager flickManager;
  // VideoPlayerController controller;
  bool _isVisible;

  double rightpadding = 140;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(widget.data.videolink),
    );
    // controller = VideoPlayerController.network(widget.data.videolink);

    if (widget.data.videolink.isEmpty) {
      _isVisible = false;
    } else {
      _isVisible = true;
    }

    // controller.addListener(() {
    //   setState(() {});
    // });
    // controller.setLooping(true);
    // controller.initialize().then((_) => setState(() {}));
    // controller.play();

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightpadding = 10;
      });
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sb = FirebaseAuth.instance;
    final Article article = widget.data;
    var showdcategorywellness = article.category;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: true,
        top: false,
        maintainBottomViewPadding: true,
        child: Column(children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                _customArticleImageAppBar(article, context),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  child: AnimatedPadding(
                                    duration: Duration(milliseconds: 0),
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: rightpadding,
                                        top: 5,
                                        bottom: 5),
                                    child: Text(
                                      '     $showdcategorywellness     ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.time_solid,
                                    size: 18, color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Open Hours",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  article.openhour,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "to",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  article.closehour,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.6,
                                  wordSpacing: 1),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              endIndent: 200,
                              thickness: 2,
                              height: 20,
                            ),
                            TextButton.icon(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(
                                    (states) =>
                                        EdgeInsets.only(left: 10, right: 10)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) =>
                                            Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3))),
                              ),
                              icon: Icon(Feather.bookmark,
                                  color: Colors.white, size: 20),
                              label: Text('Booking Now!',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                nextScreenAllApp(
                                    context,
                                    FormBookingNow(
                                      articleID: article.cid,
                                      titleID: article.title,
                                      imageID: article.image,
                                      detailID: article.detail,
                                      openhourID: article.openhour,
                                      closehourID: article.closehour,
                                      addressID: article.address,
                                      categoryID: article.category,
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ViewsArticleDetail(
                                  article: article,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Address:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 124, 41, 3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ArticleBodyWidgetHtml(
                              htmlData: article.address,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Detail:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 124, 41, 3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ArticleBodyWidgetHtml(
                              htmlData: article.detail,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Visibility(
                                visible: _isVisible,
                                child: FlickVideoPlayer(
                                    flickManager: flickManager),
                                // child: InkWell(
                                //   onTap: () {
                                //     if (controller.value.isPlaying) {
                                //       controller.pause();
                                //     } else {
                                //       controller.play();
                                //     }
                                //   },
                                //   child: AspectRatio(
                                //     aspectRatio: controller.value.aspectRatio,
                                //     child: VideoPlayer(controller),
                                //   ),
                                // )
                              ),
                            ),
                            // Container(
                            //   child: Visibility(
                            //     visible: _isVisible,
                            //     //duration of video
                            //     child: Text("Total Duration: " +
                            //         controller.value.duration.toString()),
                            //   ),
                            // ),
                            // Container(
                            //   child: Visibility(
                            //       visible: _isVisible,
                            //       child: VideoProgressIndicator(controller,
                            //           allowScrubbing: true,
                            //           colors: VideoProgressColors(
                            //             backgroundColor: Colors.redAccent,
                            //             playedColor: Colors.green,
                            //             bufferedColor: Colors.purple,
                            //           ))),
                            // ),
                            // Container(
                            //   child: Visibility(
                            //       visible: _isVisible,
                            //       child: Row(
                            //         children: [
                            //           IconButton(
                            //               onPressed: () {
                            //                 if (controller.value.isPlaying) {
                            //                   controller.pause();
                            //                 } else {
                            //                   controller.play();
                            //                 }

                            //                 setState(() {});
                            //               },
                            //               icon: Icon(controller.value.isPlaying
                            //                   ? Icons.pause
                            //                   : Icons.play_arrow)),
                            //           IconButton(
                            //               onPressed: () {
                            //                 controller
                            //                     .seekTo(Duration(seconds: 0));

                            //                 setState(() {});
                            //               },
                            //               icon: Icon(Icons.stop))
                            //         ],
                            //       )),
                            // ),
                            // Center(
                            //     child: InkWell(
                            //   onTap: () {
                            //     if (controller.value.isPlaying) {
                            //       controller.pause();
                            //     } else {
                            //       controller.play();
                            //     }
                            //   },
                            //   child: AspectRatio(
                            //     aspectRatio: controller.value.aspectRatio,
                            //     child: VideoPlayer(controller),
                            //   ),
                            // )),
                            SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: ArticleBodyWidgetHtml(
                                htmlData: article.videotitle,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  SliverAppBar _customArticleImageAppBar(
      Article article, BuildContext context) {
    return SliverAppBar(
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
          background: widget.tag == null
              ? CustomCacheImage(imageUrl: article.image, radius: 0.0)
              : Hero(
                  tag: widget.tag,
                  child: CustomCacheImage(imageUrl: article.image, radius: 0.0),
                )),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_backspace,
            size: 22, color: Colors.deepOrange),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
