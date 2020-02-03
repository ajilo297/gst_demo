part of sale_view;

class _SaleMobile extends StatelessWidget {
  final SaleViewModel viewModel;

  _SaleMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale'),
      ),
      body: Form(
        key: viewModel.formKey,
        child: ListView(
          children: <Widget>[
            buildDropdown(),
            buildTextField(
              controller: viewModel.itemIdController,
              label: 'Product ID',
              enabled: false,
            ),
            buildTextField(
                label: 'Product Name',
                enabled: false,
                controller: viewModel.nameController,
                onSaved: (value) {
                  viewModel.name = value;
                }),
            buildTextField(
              controller: viewModel.priceController,
              enabled: false,
              label: 'Buying Price',
            ),
            buildTextField(
              controller: viewModel.dateTimeController,
              enabled: false,
              label: 'Date of Purchase',
            ),
            buildTextField(
              controller: viewModel.sellingPriceController,
              label: 'Selling Price',
              enabled: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) return 'Enter price';
                double price = double.tryParse(value);
                if (price == null) return 'Enter a valid price';
                return null;
              },
              onChanged: (value) {
                viewModel.updatePrice();
              },
              onSaved: (value) {
                viewModel.price = double.tryParse(value);
              },
            ),
            CheckboxListTile(
              title: Text('Is interstate'),
              onChanged: (value) => viewModel.isInterstate = value,
              value: () {
                if (viewModel.isInterstate == null) {
                  print('IsInterstate is null');
                  return false;
                }
                return viewModel.isInterstate;
              }(),
            ),
            buildTextField(
              controller: viewModel.sgstController,
              enabled: false,
              label: 'SGST',
              onSaved: (value) {
                viewModel.sgst = double.parse(value);
              },
            ),
            buildTextField(
              controller: viewModel.cgstController,
              enabled: false,
              label: 'CGST',
              onSaved: (value) {
                viewModel.cgst = double.parse(value);
              },
            ),
            buildTextField(
                controller: viewModel.igstController,
                enabled: false,
                label: 'IGST',
                onSaved: (value) {
                  viewModel.igst = double.parse(value);
                }),
            buildTextField(
              controller: viewModel.dateOfSaleController,
              label: 'Date of Purchase',
              enabled: true,
              textCapitalization: TextCapitalization.characters,
              hint: 'dd-mm-yyyy',
              keyboardType: TextInputType.numberWithOptions(),
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
          ],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Sell',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          viewModel.save();
        },
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField<PurchaseModel>(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: viewModel.dropdownHintText,
        ),
        validator: (value) {
          if (value == null) return 'Select an item to sell';
          return null;
        },
        isDense: false,
        isExpanded: true,
        selectedItemBuilder: (context) {
          return viewModel.purchaseModels.map((model) {
            return Text(model.name);
          }).toList();
        },
        onChanged: (value) {
          viewModel.selectedPurchaseModel = value;
        },
        value: viewModel.selectedPurchaseModel,
        items: viewModel.purchaseModels.map(
          (model) {
            return DropdownMenuItem<PurchaseModel>(
              child: ListTile(
                title: Text(model.name),
                subtitle: Text(
                  model.price.toStringAsFixed(2),
                ),
              ),
              value: model,
            );
          },
        ).toList(),
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
