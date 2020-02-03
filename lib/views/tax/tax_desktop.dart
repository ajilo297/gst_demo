part of tax_view;

class _TaxDesktop extends StatelessWidget {
  final TaxViewModel viewModel;

  _TaxDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TaxDesktop')),
    );
  }
}