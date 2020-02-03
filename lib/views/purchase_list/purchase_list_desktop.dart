part of purchase_list_view;

class _PurchaseListDesktop extends StatelessWidget {
  final PurchaseListViewModel viewModel;

  _PurchaseListDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PurchaseListDesktop')),
    );
  }
}