import 'dart:typed_data';

import 'package:orca_ai/data/data.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfSerivce {
  Future<Uint8List?> create(DocDto doc, UserDto user) async {
    final pdf = pw.Document();
    pw.Image? signature;
    // Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // // final img = await rootBundle.load("${appDocumentsDir.path}/signature.png");
    // // final imageBytes = img.buffer.asUint8List();

    // File img = File("${appDocumentsDir.path}/signature.png");

    // if (await img.exists()) {
    //   final imgBytes = await img.readAsBytes();
    //   signature = pw.Image(pw.MemoryImage(imgBytes));
    // }

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if ((doc.title ?? '').isNotEmpty) ...[
                  pw.Text(
                    doc.title ?? '',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
                if ((doc.ac ?? '').isNotEmpty) ...[
                  pw.Text(
                    'Para: ${doc.ac ?? ''}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
                if ((doc.description ?? '').isNotEmpty) ...[
                  pw.Text(
                    'Descrição:',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Text(
                    doc.description ?? '',
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 64),
                ],
                if ((doc.value ?? '').isNotEmpty) ...[
                  pw.Text(
                    "Valor total do orçamento: ${doc.value ?? ''} ${(doc.valueInFull ?? '').isNotEmpty ? "(${doc.valueInFull ?? ''})" : ""}",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
                pw.Text(
                  "Condições de pagamento: ",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  "Pagamento 50% no fechamento e 50% no término da obra.",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.SizedBox(height: 64),
                if (signature != null) ...[
                  pw.Container(
                    alignment: pw.Alignment.center,
                    width: 160,
                    child: signature,
                  ),
                  pw.SizedBox(height: 16),
                ],
                pw.Text(
                  "${user.name} - ${user.phone}",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    return await pdf.save();
  }
}
