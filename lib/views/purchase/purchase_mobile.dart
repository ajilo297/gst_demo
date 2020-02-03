part of purchase_view;

class _PurchaseMobile extends StatelessWidget {
  final PurchaseViewModel viewModel;

  _PurchaseMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
      ),
      body: Form(
        key: viewModel.formKey,
        child: ListView(
          children: <Widget>[
            buildTextField(
                enabled: false,
                controller: viewModel.itemIdController,
                label: 'Item ID',
                onSaved: (value) {
                  viewModel.itemId = value;
                }),
            buildTextField(
              controller: viewModel.nameController,
              label: 'Product Name',
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) return 'Name is required';
                return null;
              },
              onSaved: (value) => viewModel.name = value,
            ),
            buildTextField(
              controller: viewModel.priceController,
              label: 'Price',
              keyboardType: TextInputType.number,
              onChanged: (_) {
                viewModel.updatePrice();
              },
              validator: (value) {
                if (value.isEmpty) return 'Price is required';
                double price = double.tryParse(value);
                if (price == null) {
                  return 'Enter a valid price';
                }
                return null;
              },
              onSaved: (value) {
                double price = double.tryParse(value);
                viewModel.price = price;
              },
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              onChanged: (bool) => viewModel.isInterState = bool,
              value: viewModel.isInterState,
              title: Text('Is Interstate'),
            ),
            buildTextField(
              controller: viewModel.cgstController,
              label: 'CGST',
              hint: '0.0',
              enabled: false,
              onSaved: (value) {
                double cgst = double.tryParse(value);
                viewModel.cgst = cgst;
              },
            ),
            buildTextField(
              controller: viewModel.sgstController,
              label: 'SGST',
              enabled: false,
              onSaved: (value) {
                double sgst = double.tryParse(value);
                viewModel.sgst = sgst;
              },
            ),
            buildTextField(
              controller: viewModel.igstController,
              label: 'IGST',
              enabled: false,
              onSaved: (value) {
                double igst = double.tryParse(value);
                viewModel.igst = igst;
              },
            ),
            buildTextField(
              controller: viewModel.dateTimeController,
              label: 'Date of Purchase',
              enabled: true,
              textCapitalization: TextCapitalization.characters,
              hint: 'dd-mm-yyyy',
              keyboardType: TextInputType.numberWithOptions(

              ),
              maxLength: 10,
              validator: (value) {
                if (value.isEmpty) return 'Date cannot be empty';
                return null;
              },
              onSaved: (value) {
                DateFormat _format = DateFormat('dd-MM-yyyy');
                DateTime dateTime = _format.parse(value);
                viewModel.dateTime = dateTime;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Purchase',
                    style: TextStyle(
                      color: Theme.of(context).accentColorBrightness ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  viewModel.save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextField({
    @required String label,
    @required TextEditingController controller,
    TextCapitalization textCapitalization = TextCapitalization.sentences,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    int maxLength,
    String hint,
    String Function(String value) validator,
    void Function(String value) onSaved,
    void Function(String value) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        textCapitalization: textCapitalization,
        validator: validator,
        enabled: enabled,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        maxLength: maxLength,
      ),
    );
  }
}
