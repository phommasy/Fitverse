import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/model/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Card2 extends StatelessWidget {
  final Article d;
  final String heroTag;
  const Card2({Key key, this.d, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: 90,
                    width: 90,
                    child: Hero(
                        tag: heroTag,
                        child:
                            CustomCacheImage(imageUrl: d.image, radius: 5.0))),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.time_solid,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Open Hours:",
                          style: TextStyle(fontSize: 12, color: Colors.black
                              //color: Theme.of(context).secondaryHeaderColor
                              ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      d.openhour,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => navigateToDetailsScreen(context, d, heroTag),
    );
  }
}
