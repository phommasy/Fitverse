import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitverse/components/appservice.dart';
import 'package:fitverse/components/fullimagebody.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleBodyWidgetHtml extends StatelessWidget {
  const ArticleBodyWidgetHtml({
    Key key,
    this.htmlData,
  }) : super(key: key);

  final String htmlData;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '''$htmlData''',
      onLinkTap: (String url, RenderContext context1,
          Map<String, String> attributes, _) {
        AppServices().openLinkWithCustomTab(context, url);
      },
      onImageTap: (String url, RenderContext context1,
          Map<String, String> attributes, _) {
        nextScreenAllApp(context, FullImageBody(imageUrl: url));
      },
      style: {
        "body": Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          fontSize: FontSize(17.0),
          lineHeight: LineHeight(1.4),
        ),
        "figure": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
        "h2": Style(letterSpacing: -0.7, wordSpacing: 0.5)
      },
      customRender: {
        "img": (RenderContext context1, Widget child) {
          final String _imageSource =
              context1.tree.element.attributes['src'].toString();
          return InkWell(
            child: Hero(
              tag: _imageSource,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(_imageSource),
                        fit: BoxFit.cover)),
              ),
            ),
            onTap: () => nextScreenAllApp(
                context, FullImageBody(imageUrl: _imageSource)),
          );
        },
      },
    );
  }
}
