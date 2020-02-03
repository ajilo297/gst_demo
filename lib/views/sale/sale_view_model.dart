import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/models/sales_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';
import 'package:intl/intl.dart';

class SaleViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController itemIdController = TextEditingController();

  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController igstController = TextEditingController();
  final TextEditingController sgstController = TextEditingController();
  final TextEditingController cgstController = TextEditingController();
  final TextEditingController dateOfSaleController = TextEditingController();

  bool _isInterstate;

  final HiveService _hiveService;

  List<PurchaseModel> _purchaseList = [];

  PurchaseModel _selectedPurchaseModel;
  SalesModel _salesModel;

  SaleViewModel({
    @required HiveService hiveService,
  }) : this._hiveService = hiveService;

  void init() async {
    log.i('init');
    isInterstate = false;
    selectedPurchaseModel = null;
    salesModel = SalesModel();
    purchaseModels = [];
    await loadPurchases();
  }

  String get dropdownHintText {
    if (purchaseModels.isEmpty) return 'No items to sell. Make a purchase first';
    return 'Select an item to sell';
  }

  List<PurchaseModel> get purchaseModels => this._purchaseList;
  set purchaseModels(List<PurchaseModel> models) {
    this._purchaseList = models;
    notifyListeners();
  }

  bool get isInterstate => this._isInterstate ?? false;
  set isInterstate(bool value) {
    this._isInterstate = value;
    updatePrice();
    notifyListeners();
  }

  SalesModel get salesModel => this._salesModel;
  set salesModel(SalesModel model) {
    this._salesModel = model;
    notifyListeners();
  }

  PurchaseModel get selectedPurchaseModel => this._selectedPurchaseModel;
  set selectedPurchaseModel(PurchaseModel model) {
    this._selectedPurchaseModel = model;
    if (model != null) {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');

      this.dateTimeController.text = dateFormat.format(model.dateTime);
      this.itemIdController.text = model.itemId.substring(0, 6);
      this.nameController.text = model.name;

      double price = model.price + model.sgst + model.igst + model.cgst;
      this.priceController.text = price.toString();
    } else {
      this.dateTimeController.text = '';
      this.itemIdController.text = '';
      this.nameController.text = '';
      this.priceController.text = '';
    }

    notifyListeners();
  }

  set cgst(num cgst) {
    _salesModel.cgst = cgst;
    notifyListeners();
  }

  set dateTime(var dateTime) {
    _salesModel.dateTime = dateTime;
    notifyListeners();
  }

  set igst(num igst) {
    _salesModel.igst = igst;
    notifyListeners();
  }

  set name(String name) {
    _salesModel.name = name;
    notifyListeners();
  }

  set price(num price) {
    _salesModel.price = price;
    notifyListeners();
  }

  set sgst(num sgst) {
    _salesModel.sgst = sgst;
    notifyListeners();
  }

  void updatePrice() {
    double price = double.tryParse(sellingPriceController.text);
    if (price == null) return;
    if (isInterstate) {
      igstController.text = '${0.18 * price}';
      sgstController.text = '0.0';
      cgstController.text = '0.0';
    } else {
      igstController.text = '0.0';
      sgstController.text = '${price * 0.09}';
      cgstController.text = '${price * 0.09}';
    }

    notifyListeners();
  }

  Future loadPurchases() async {
    log.i('loadPurchases');
    purchaseModels = await _hiveService.getUnsoldItems();
    purchaseModels.forEach((model) {
      log.d('loadPurchases: model: ${model.name}');
    });
    purchaseModels.sort((p1, p2) {
      return p1.dateTime.compareTo(p2.dateTime);
    });
  }

  void save() async {
    log.i('save');
    FormState formState = formKey.currentState;
    if (formState == null) {
      log.i('save: Form Key is null');
      return;
    }
    if (!formState.validate()) {
      log.e('save: Form validation failed');
      return;
    }

    salesModel.itemId = selectedPurchaseModel.itemId;
    formState.save();

    log.i('-------------------');
    salesModel.toMap().forEach((k, v) {
      log.i('save: $k: ${v.toString()}');
    });
    log.i('-------------------');

    await _hiveService.saveSale(salesModel);
    init();
  }
}
