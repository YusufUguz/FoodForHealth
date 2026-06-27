import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_for_health/features/barcode_scan/view/barcode_scan_view.dart';
import 'package:food_for_health/features/food_evaluation/view/food_evaluation_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

mixin BarcodeScanViewMixin on State<BarcodeScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ValueNotifier<Barcode?> result = ValueNotifier(null);
  ValueNotifier<QRViewController?> controller = ValueNotifier(null);
  bool hasNavigated = false;
  @override
  void reassemble() {
    super.reassemble();
    if (defaultTargetPlatform == TargetPlatform.android) {
      controller.value?.pauseCamera();
    }
    controller.value?.resumeCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller.value = controller;
    controller.scannedDataStream.listen((scanData) {
      result.value = scanData;
      if (result.value != null && mounted && !hasNavigated) {
        hasNavigated = true;
        controller.pauseCamera();
        controller.dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodEvaluationView(barcode: result.value!),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.value?.dispose();
    controller.value?.pauseCamera();
    super.dispose();
  }
}
