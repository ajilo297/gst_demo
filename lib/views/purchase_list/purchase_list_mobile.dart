part of purchase_list_view;

class _PurchaseListMobile extends StatelessWidget {
  final PurchaseListViewModel viewModel;

  _PurchaseListMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchases'),
      ),
      body: ListView.builder(
        itemCount: viewModel.purchaseModels.length,
        itemBuilder: (context, index) {
          PurchaseModel model = viewModel.purchaseModels.elementAt(index);
          double price = model.price + model.cgst + model.sgst + model.igst;
          return ListTile(
            title: Text(model.name),
            subtitle: Text(
              getFormattedDate(model.dateTime),
            ),
            trailing: Text(price.toStringAsFixed(2)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Purchase'),
        onPressed: () {
          viewModel.navigateToAddPurchase();
        },
      ),
    );
  }

  String getFormattedDate(DateTime dateTime) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    return format.format(dateTime);
  }
}
