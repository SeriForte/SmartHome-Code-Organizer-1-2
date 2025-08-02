import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'file_service.dart';

class TablePdfApi {
  static Future<File> generateTablePdf(
      {required List<SmartDevice> deviceList}) async {
    


    final pdf = Document();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4.landscape,
      orientation: PageOrientation.landscape,
    );


    // const double headerSize = (5 * PdfPageFormat.mm);
    const double paddingSize = (5 * PdfPageFormat.mm);
    const double dividerHeight = (1 * PdfPageFormat.mm);
    const double rowHeight = (41 * PdfPageFormat.mm);
    const double col1HeaderWidth = (20 * PdfPageFormat.mm);
    const double col1ContentWidth = (44 * PdfPageFormat.mm);
    const double col2HeaderWidth = (30 * PdfPageFormat.mm);
    const double col2ContentWidth = (100 * PdfPageFormat.mm);

    Widget smallDivider() {
      return Divider(
        thickness: 0.3,
        height: dividerHeight,
        indent: paddingSize,
        endIndent: paddingSize,
        color: PdfColors.lightBlue200,
      );
    }

    Widget subHeader1(String title) {
      return SizedBox(
        width: col1HeaderWidth,
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      );
    }

    Widget subHeader2(String title) {
      return SizedBox(
        width: col2HeaderWidth,
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      );
    }

    Widget subContent1(String title) {
      return SizedBox(
        width: col1ContentWidth,
        child: Text(title),
      );
    }

    Widget subContent2(String title) {
      return SizedBox(
        width: col2ContentWidth,
        child: Text(title, softWrap: true),
      );
    }

    // TableRow tableHeader() {
    //   return TableRow(
    //     verticalAlignment: TableCellVerticalAlignment.middle,
    //     decoration: const BoxDecoration(color: PdfColors.amber100),
    //     children: [
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('QR',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Typ',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Key',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('SGTIN',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Name',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Beschreibung',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Raum',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Etage',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //       SizedBox(
    //           width: 36 * PdfPageFormat.mm,
    //           child: Center(
    //             child: Text('Haus',
    //                 style: TextStyle(
    //                     fontSize: headerSize, fontWeight: FontWeight.bold)),
    //           )),
    //     ],
    //   );
    // }

    final dataTR = deviceList
        .map((e) => TableRow(children: [
              SizedBox(
                  height: rowHeight,
                  width: rowHeight,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(paddingSize),
                    child: BarcodeWidget(
                        data: e.qrCode,
                        width: 36 * PdfPageFormat.mm,
                        height: 36 * PdfPageFormat.mm,
                        barcode: Barcode.qrCode(),
                        drawText: false),
                  ))),
              SizedBox(
                  width: col1HeaderWidth + col1ContentWidth,
                  child: Column(children: [
                    SizedBox(height: paddingSize),
                    Row(children: [
                      subHeader1('Type'),
                      subContent1(e.deviceType)
                    ]),
                    smallDivider(),
                    Row(children: [subHeader1('Key'), subContent1(e.smartKey)]),
                    smallDivider(),
                    Row(children: [subHeader1('SGTIN'), subContent1(e.sgtin)]),
                  ])),
              SizedBox(width: paddingSize),
              SizedBox(
                  width: col2ContentWidth + col2HeaderWidth,
                  child: Column(children: [
                    SizedBox(height: paddingSize),
                    Row(children: [subHeader2('Name'), subContent2(e.name)]),
                    smallDivider(),
                    Row(children: [
                      subHeader2('Beschreibung'),
                      subContent2(e.description)
                    ]),
                    smallDivider(),
                    Row(children: [subHeader2('Raum'), subContent2(e.room)]),
                    smallDivider(),
                    Row(children: [subHeader2('Etage'), subContent2(e.floor)]),
                    smallDivider(),
                    Row(children: [
                      subHeader2('Haus'),
                      subContent2(e.building)
                    ]),
                  ])),
            ]))
        .toList();

    pdf.addPage(MultiPage(
        pageTheme: pageTheme,
        footer: (context) => buildPageNumber(context),
        build: (context) {
          return [
            Table(
              // border: TableBorder.all(width: 2),
              border: const TableBorder(
                  horizontalInside: BorderSide(color: PdfColors.blue300)),

              children: [
                //tableHeader,

                ...dataTR,
              ],
            )
          ];
        }));

    return SaveAndOpenDocument.savePdf(name: 'tablePdf.pdf', pdf: pdf);
  }

  static Widget buildPageNumber(Context context) {
    final now = DateTime.now();
    const double footerAppInfo = (4 * PdfPageFormat.mm);
    const double footerPageInfo = (2 * PdfPageFormat.mm);
    const double footerDateInfo = (2 * PdfPageFormat.mm);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text('Smart Home Organizer App',
            style: TextStyle(
                fontSize: footerAppInfo,
                color: PdfColors.blue200,
                fontStyle: FontStyle.italic)),
        Text(
          'Seite ${context.pageNumber} von ${context.pagesCount}',
          style: const TextStyle(fontSize: footerPageInfo),
        ),
        Text('Erstellt am ${now.day}.${now.month}.${now.year}',
            style: const TextStyle(fontSize: footerDateInfo)),
      ]),
    );
  } 
}
