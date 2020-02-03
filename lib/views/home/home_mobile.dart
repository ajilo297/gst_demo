part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel viewModel;

  _HomeMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              saleButton,
              SizedBox(height: 16),
              purchaseButton,
              SizedBox(height: 16),
              taxButton,
              SizedBox(height: 16),
              clearButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get saleButton {
    return buildButton('Sales', viewModel.navigateToSale);
  }

  Widget get purchaseButton {
    return buildButton('Purchase', viewModel.navigateToPurchase);
  }

  Widget get taxButton {
    return buildButton('Tax', viewModel.navigateToTax);
  }

  Widget get clearButton {
    return buildButton('Clear', viewModel.clear);
  }

  Widget buildButton(String title, VoidCallback onPressed) {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
