import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends ConsumerStatefulWidget {
  const ScanCodeScreen({super.key});

  static const route = '/scan';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanCodeScreenState();
}

class _ScanCodeScreenState extends ConsumerState<ScanCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR-Code'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final element in barcodes) {
            debugPrint('Barcode found: ${element.rawValue}');
          }
        },
      ),
    );
  }
}
