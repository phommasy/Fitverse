import 'package:fitverse/components/articlebodyhtmlwidget.dart';
import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/viewsarticledetail.dart';
import 'package:fitverse/model/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ArticleDatailAll extends StatefulWidget {
  final Article data;
  final String tag;
  const ArticleDatailAll({Key key, this.data, this.tag}) : super(key: key);

  @override
  State<ArticleDatailAll> createState() => _ArticleDatailAllState();
}

class _ArticleDatailAllState extends State<ArticleDatailAll> {
  double rightpadding = 140;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightpadding = 10;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Article article = widget.data;
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
                                    duration: Duration(milliseconds: 1000),
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: rightpadding,
                                        top: 5,
                                        bottom: 5),
                                    child: Text(
                                      article.category,
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
                              onPressed: () {},
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
                            ArticleBodyWidgetHtml(
                              htmlData: article.detail,
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