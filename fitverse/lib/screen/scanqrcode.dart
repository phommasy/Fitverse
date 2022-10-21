import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRcodeNew extends StatefulWidget {
  const ScanQRcodeNew({Key key}) : super(key: key);

  @override
  State<ScanQRcodeNew> createState() => _ScanQRcodeNewState();
}

class _ScanQRcodeNewState extends State<ScanQRcodeNew> {
  String _scanBarcode = 'Unknown';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scan QR code")),
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => scanQR(),
                        child: const Text("Scan QRcode for attend",
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text("Scan result: $_scanBarcode\n",
                          style: const TextStyle(fontSize: 18))
                    ])),
          );
        }));
  }
}
