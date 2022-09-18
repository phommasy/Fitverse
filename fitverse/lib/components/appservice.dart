import 'dart:io';
import 'package:fitverse/components/appinfosetting.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'config.dart';

class AppServices {
  Future openLink(context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      Fluttertoast.showToast(
          msg: "Can't launch the url", gravity: ToastGravity.TOP);
    }
  }

  Future openEmailSupport(context) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: Config.supportEmail,
      query:
          'subject=About ${Config.appName}&body=', //add subject and body here
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Fluttertoast.showToast(
          msg: "Can't open the email app", gravity: ToastGravity.TOP);
    }
  }

  Future launchAppReview(context) async {
    final SettingsBloc sb = Provider.of<SettingsBloc>(context, listen: false);
    LaunchReview.launch(
        androidAppId: sb.packageName,
        iOSAppId: Config.iOSAppID,
        writeReview: false);
    if (Platform.isIOS) {
      if (Config.iOSAppID == '000000') {
        Fluttertoast.showToast(
            msg: "The iOS version is not available", gravity: ToastGravity.TOP);
      }
    }
  }

  Future openLinkWithCustomTab(BuildContext context, String url) async {
    try {
      await FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Can not launch the url", gravity: ToastGravity.TOP);
      debugPrint(e.toString());
    }
  }
}
