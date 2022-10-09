import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/model/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryBaseArticleCard2 extends StatelessWidget {
  final Article d;
  final String heroTag;
  const CategoryBaseArticleCard2({Key key, this.d, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(15),
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orangeAccent[600]),
                          child: Text(
                            d.category,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Hero(
                      tag: heroTag,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomCacheImage(
                                imageUrl: d.image, radius: 5.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.time,
                    color: Colors.black,
                    size: 20,
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
                  Spacer(),
                ],
              )
            ],
          )),
      onTap: () => navigateToDetailsScreen(context, d, heroTag),
    );
  }
}
