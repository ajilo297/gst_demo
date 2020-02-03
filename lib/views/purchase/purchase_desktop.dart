part of purchase_view;

class _PurchaseDesktop extends StatelessWidget {
  final PurchaseViewModel viewModel;

  _PurchaseDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PurchaseDesktop')),
    );
  }
}