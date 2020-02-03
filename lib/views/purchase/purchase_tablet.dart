part of purchase_view;

class _PurchaseTablet extends StatelessWidget {
  final PurchaseViewModel viewModel;

  _PurchaseTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PurchaseTablet')),
    );
  }
}