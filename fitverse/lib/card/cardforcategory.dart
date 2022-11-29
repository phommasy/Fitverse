import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/model/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';

class CategoryBaseArticleCard extends StatelessWidget {
  final Article d;
  final String heroTag;
  const CategoryBaseArticleCard({Key key, this.d, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ]),
        child: Wrap(
          children: [
            Hero(
              tag: heroTag,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: CustomCacheImage(
                      imageUrl: d.image,
                      radius: 5.0,
                      circularShape: false,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      HtmlUnescape()
                          .convert(parse(d.address).documentElement.text),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 12,
                          //color: Theme.of(context).secondaryHeaderColor
                          color: Colors.black)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Open Hours:",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.openhour,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "to",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.closehour,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => navigateToDetailsScreen(context, d, heroTag),
    );
  }
}
