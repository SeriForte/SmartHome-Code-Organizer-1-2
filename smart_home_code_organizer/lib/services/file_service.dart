import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class SaveAndOpenDocument {
  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final slash = Platform.isWindows ? '\\' : '/';

    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final file = File('${root!.path}$slash$name');
    await file.writeAsBytes(await pdf.save());

    debugPrint('${root.path}$slash$name');
    return file;
  }

  static Future<void> openPdf(File file) async {
    final path = file.path;
    await OpenFile.open(path);
  }
}
