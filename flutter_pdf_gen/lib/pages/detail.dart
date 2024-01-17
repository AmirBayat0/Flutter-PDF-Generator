import 'package:flutter/material.dart';
import 'package:flutter_pdf_gen/models/bill_model.dart';
import 'package:flutter_pdf_gen/pages/preview.dart';

class DetailPage extends StatelessWidget {
  final BillModel singleBillItem;
  const DetailPage({
    Key? key,
    required this.singleBillItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(context),
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  /// Body
  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Customer',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  singleBillItem.customer,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Text(
                    'Bill Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ...singleBillItem.items.map(
                    (e) => ListTile(
                      title: Text(e.description),
                      trailing: Text(
                        e.cost.toStringAsFixed(2),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headlineMedium,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Total"),
                        Text(
                          "\$${singleBillItem.totalCost().toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        singleBillItem.name,
        maxLines: 2,
      ),
    );
  }

  /// Floating Action Button
  Widget _fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PdfPreviewPage(bill: singleBillItem),
          ),
        );
        // rootBundle.
      },
      child: const Icon(Icons.picture_as_pdf),
    );
  }
}
