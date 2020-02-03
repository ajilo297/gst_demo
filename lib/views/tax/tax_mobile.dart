part of tax_view;

class _TaxMobile extends StatelessWidget {
  final TaxViewModel viewModel;

  _TaxMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tax Details')),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Date',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Text(
                  'Price',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Text(
                  'CGST',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Text(
                  'SGST',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Text(
                  'IGST',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Text(
                  'Total Price',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
            rows: viewModel.data.map(
              (data) {
                DateFormat format = DateFormat('dd/MM/yy');
                String date = format.format(data.dateTime);

                double price = data.price + data.igst + data.cgst + data.sgst;
                return DataRow(
                  cells: [
                    DataCell(
                      Text(date,
                          style: TextStyle(
                            color: data.type == TxnType.PURCHASE
                                ? Colors.red
                                : Colors.green,
                          )),
                    ),
                    DataCell(
                      Text(data.name,
                          style: TextStyle(
                            color: data.type == TxnType.PURCHASE
                                ? Colors.red
                                : Colors.green,
                          )),
                    ),
                    DataCell(Text(data.price.toStringAsFixed(2),
                        style: TextStyle(
                          color: data.type == TxnType.PURCHASE
                              ? Colors.red
                              : Colors.green,
                        ))),
                    DataCell(Text(data.cgst.toStringAsFixed(2),
                        style: TextStyle(
                          color: data.type == TxnType.PURCHASE
                              ? Colors.red
                              : Colors.green,
                        ))),
                    DataCell(Text(data.sgst.toStringAsFixed(2),
                        style: TextStyle(
                          color: data.type == TxnType.PURCHASE
                              ? Colors.red
                              : Colors.green,
                        ))),
                    DataCell(Text(data.igst.toStringAsFixed(2),
                        style: TextStyle(
                          color: data.type == TxnType.PURCHASE
                              ? Colors.red
                              : Colors.green,
                        ))),
                    DataCell(Text(price.toStringAsFixed(2),
                        style: TextStyle(
                          color: data.type == TxnType.PURCHASE
                              ? Colors.red
                              : Colors.green,
                        ))),
                  ],
                );
              },
            ).toList()
              ..add(
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        viewModel.sumPrice.toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        viewModel.sumCgst.toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        viewModel.sumSgst.toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        viewModel.sumIgst.toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(
                      Text(
                        viewModel.sumTotal.toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
