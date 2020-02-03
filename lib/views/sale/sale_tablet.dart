part of sale_view;

class _SaleTablet extends StatelessWidget {
  final SaleViewModel viewModel;

  _SaleTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SaleTablet')),
    );
  }
}