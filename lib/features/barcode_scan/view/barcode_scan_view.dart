import 'package:flutter/material.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/features/barcode_scan/view_model/barcode_scan_view_mixin.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScanView extends StatefulWidget {
  const BarcodeScanView({super.key});

  @override
  State<BarcodeScanView> createState() => _BarcodeScanViewState();
}

class _BarcodeScanViewState extends State<BarcodeScanView> with BarcodeScanViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            top: 0,
            child: QRView(
              overlay: QrScannerOverlayShape(borderWidth: 800, borderLength: 200),
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.appsMainColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Center(
                    child: Text(
                  "Ürün barkodunu okutarak ürünle ilgili bilgiler edinebilirsiniz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
          ),
        ],
      ),
    );
  }
}
