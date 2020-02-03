part of sale_view;

class _SaleDesktop extends StatelessWidget {
  final SaleViewModel viewModel;

  _SaleDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SaleDesktop')),
    );
  }
}