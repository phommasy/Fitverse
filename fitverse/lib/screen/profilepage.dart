import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/screen/comfirmscan.dart';
import 'package:fitverse/screen/login.dart';
import 'package:fitverse/screen/scanqrcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:fitverse/components/appservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/appinfosetting.dart';
import '../components/config.dart';

class ProfilepageScreen extends StatefulWidget {
  @override
  State<ProfilepageScreen> createState() => _ProfilepageScreenState();
}

class _ProfilepageScreenState extends State<ProfilepageScreen> {
  final auth = FirebaseAuth.instance;
  void openLicenceDialog() {
    final SettingsBloc sb = Provider.of<SettingsBloc>(context, listen: false);
    showDialog(
        context: context,
        builder: (_) {
          return AboutDialog(
            applicationName: Config.appName,
            applicationVersion: sb.appVersion,
            applicationIcon: Image(
              image: AssetImage(Config.appIcon),
              height: 30,
              width: 30,
            ),
          );
        });
  }

  String _scanBarcode = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    setState(() {
      _scanBarcode = barcodeScanRes;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanQRcodeComfirm(
              qrcoderesult: _scanBarcode,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 140,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title:
                  Text('Profile Page', style: TextStyle(color: Colors.white)),
              titlePadding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Info',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 233, 87, 30),
                            radius: 18,
                            child: Icon(
                              Feather.mail,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            auth.currentUser.email,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 233, 87, 30),
                              radius: 18,
                              child: Icon(
                                Icons.qr_code,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Scan QR code',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            onTap: () => scanQR()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About App',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.pinkAccent,
                            radius: 18,
                            child: Icon(
                              Feather.star,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Rate This App',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppServices().launchAppReview(context),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            radius: 18,
                            child: Icon(
                              Feather.lock,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Licence',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => openLicenceDialog(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact US',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent[100],
                            radius: 18,
                            child: Icon(
                              Feather.mail,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppServices().openEmailSupport(context),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 18,
                            child: Icon(
                              Feather.facebook,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Facebook Page',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppServices()
                              .openLink(context, Config.facebookPageUrl),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 175, 6, 119),
                            radius: 18,
                            child: Icon(
                              Feather.instagram,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Instagram',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppServices().openLinkWithCustomTab(
                              context, Config.websiteSupport),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 241, 8, 8),
                            radius: 18,
                            child: Icon(
                              Feather.log_out,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => LogoutDialogpage(context),
                          // onTap: () {
                          //   auth.signOut().then((value) {
                          //     Navigator.pushReplacement(context,
                          //         MaterialPageRoute(builder: (context) {
                          //       return LoginScreen();
                          //     }));
                          //   });
                          // },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void LogoutDialogpage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Would you like to log out?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.pop(context);
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  });
                },
              )
            ],
          );
        });
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.0,
      thickness: 0.2,
      indent: 50,
      color: Colors.grey[400],
    );
  }
}
