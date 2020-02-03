part of tax_view;

class _TaxTablet extends StatelessWidget {
  final TaxViewModel viewModel;

  _TaxTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TaxTablet')),
    );
  }
}