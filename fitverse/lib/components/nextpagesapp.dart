import 'package:fitverse/model/contents.dart';
import 'package:fitverse/screen/articleDetail.dart';
import 'package:flutter/material.dart';

void nextScreenAllApp(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPopup(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
  );
}

void navigateToDetailsScreen(context, Article article, String heroTag) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ArticleDatailAll(
              data: article,
              tag: heroTag,
            )),
  );
}

void navigateToDetailsScreenByReplace(
    context, Article article, String heroTag, bool replace) {
  if (replace == null || replace == false) {
    navigateToDetailsScreen(context, article, heroTag);
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ArticleDatailAll(
                data: article,
                tag: heroTag,
              )),
    );
  }
}
