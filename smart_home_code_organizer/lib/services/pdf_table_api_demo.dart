import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'file_service.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class TablePdfDemoApi {
  static Future<File> generateTablePdf() async {
    final pdf = Document();
    final headers = ['Name', 'Age'];
    final users = [
      const User(name: 'James', age: 19),
      const User(name: 'Sarah', age: 21),
      const User(name: 'Emma', age: 2),
      const User(name: 'Benedikt', age: 1),
    ];

    final data = users.map((e) => [e.name, e.age]).toList();

    final dataTR = users
        .map((e) => TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: BarcodeWidget(
                    data: e.name,
                    width: 60,
                    height: 60,
                    barcode: Barcode.qrCode(),
                    drawText: false),
              ),
              Text(e.name),
              Text(e.name)
            ]))
        .toList();

    pdf.addPage(Page(
      build: (context) {
        return Table(
          border: TableBorder.all(width: 5),
          children: [
            TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              decoration: const BoxDecoration(color: PdfColors.amber100),
              children: [
                Text('QR',
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                Text('Name',
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                Text('Age',
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              ],
            ),
            ...dataTR,
          ],
        );
      },
    ));

    pdf.addPage(Page(
      build: (context) => TableHelper.fromTextArray(
        data: data,
        headers: headers,
        cellAlignment: Alignment.center,
        tableWidth: TableWidth.max,
        headerHeight: 150,
        cellHeight: 100,
        border: TableBorder.all(width: 5),
        headerStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        cellStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ));
    return SaveAndOpenDocument.savePdf(name: 'tablePdf', pdf: pdf);
  }
}
