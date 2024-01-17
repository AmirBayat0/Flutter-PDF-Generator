import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import '../../models/bill_model.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> pdfBuilder(BillModel bill) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/tec-1.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Attention to: ${bill.customer}"),
                    Text(bill.address),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(
                    imageLogo,
                  ),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'BILL FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ...bill.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        flex: 2,
                        child: textAndPadding(e.description),
                      ),
                      Expanded(
                        flex: 1,
                        child: textAndPadding("\$${e.cost}"),
                      )
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    textAndPadding('TAX', align: TextAlign.right),
                    textAndPadding(
                        '\$${(bill.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                TableRow(
                  children: [
                    textAndPadding('TOTAL', align: TextAlign.right),
                    textAndPadding(
                        '\$${(bill.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
            ),
            Text(
                "Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    textAndPadding('Account Number'),
                    textAndPadding(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    textAndPadding(
                      'Account Name',
                    ),
                    textAndPadding(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    textAndPadding(
                      'Total Amount to be Paid',
                    ),
                    textAndPadding(
                        '\$${(bill.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: Theme.of(context).header2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget textAndPadding(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(1),
      child: Text(
        text,
        textAlign: align,
      ),
    );
