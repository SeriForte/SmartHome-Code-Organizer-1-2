import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'file_service.dart';

class ImagePdfApi {
  static Future<File> generateImagePdf() async {
    final pdf = Document();

    final image1 =
        (await rootBundle.load('assets/img/img1.jpeg')).buffer.asUint8List();
    final image2 =
        (await rootBundle.load('assets/img/img2.jpeg')).buffer.asUint8List();

    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        buildBackground: (context) {
          if (context.pageNumber == 2) {
            return FullPage(
              ignoreMargins: true,
              child: Image(MemoryImage(image1), fit: BoxFit.cover),
            );
          } else {
            return Container();
          }
        });

    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          Image(MemoryImage(image1)),
          Center(
            child: Image(
              MemoryImage(image2),
              width: pageTheme.pageFormat.availableWidth / 2,
              height: 600,
            ),
          ),
          ClipRRect(
            verticalRadius: 32,
            horizontalRadius: 32,
            child: Image(MemoryImage(image1)),
          )
        ],
      ),
    );

    return SaveAndOpenDocument.savePdf(name: 'imagePdf.pdf', pdf: pdf);
  }
}
