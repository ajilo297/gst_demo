part of purchase_list_view;

class _PurchaseListTablet extends StatelessWidget {
  final PurchaseListViewModel viewModel;

  _PurchaseListTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PurchaseListTablet')),
    );
  }
}